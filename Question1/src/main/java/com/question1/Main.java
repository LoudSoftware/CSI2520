/*
 * Copyright (c) 2018. Nicolas Znamenski
 */

package com.question1;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.question1.model.WadingPool; // Our wading pool model

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.reflect.Type;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;


public class Main {
    private final String filename;
    private Gson gson;
    private static final Type wadingPoolType = new TypeToken<List<WadingPool>>() {
    }.getType();
    private List<WadingPool> data = new ArrayList<>(100);
    private JsonReader reader;

    private List<WadingPool> finalRoute = new ArrayList<>(100);


    private Main(String filename) {
        this.filename = filename;

        /**
         * Grabs the data and puts it in data
         */
        getData();

        data.sort(Comparator.naturalOrder()); //Sorting from west-most to east-most
        System.out.println("__Sorted Pools__");
        for (WadingPool pool :
                data) {
            System.out.println(pool);
        }
        System.out.println("__END SORTED POOLS__");

        System.out.println("Building route...");
        buildRoute(); // Builds the route through all the pools
        System.out.println("Route build finished!");

        for (WadingPool pool :
                finalRoute) {
            DecimalFormat df = new DecimalFormat("#####.#");
            System.out.println(pool.getName() + ": " + df.format(pool.getCumulativeDistance()));
        }
    }

    @SuppressWarnings("ComparatorMethodParameterNotUsed")
    private void buildRoute() {

        finalRoute.add(data.get(0));
        data.remove(0);
        finalRoute.get(0).setCumulativeDistance(0);

        while (!data.isEmpty()) {
            WadingPool root = finalRoute.get(finalRoute.size() - 1);

            data.sort((o1, o2) -> (int) p2pDistance(root, o2));

            WadingPool closest = data.get(0);

            root.setLeft(closest);
            closest.setParent(root);
            double cumulativeDistance = root.getCumulativeDistance() + p2pDistance(root, closest);
            closest.setCumulativeDistance(cumulativeDistance);
            finalRoute.add(closest);
            data.remove(closest);
        }
    }


    private void getData() {
        this.gson = new Gson();
        // Try to read the file
        try {
            reader = new JsonReader(new FileReader(filename));
            data = gson.fromJson(reader, wadingPoolType);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private double p2pDistance(WadingPool x, WadingPool y) {
        double lat1 = x.getCoordinates().get(0);
        double lat2 = y.getCoordinates().get(0);
        double lon1 = x.getCoordinates().get(1);
        double lon2 = y.getCoordinates().get(1);

        double R = 6371; // metres
        double f1 = Math.toRadians(lat1);
        double f2 = Math.toRadians(lat2);
        double df = Math.toRadians(lat2 - lat1);
        double dl = Math.toRadians(lon2 - lon1);

        double a = Math.sin(df / 2) * Math.sin(df / 2) +
                Math.cos(f1) * Math.cos(f2) *
                        Math.sin(dl / 2) * Math.sin(dl / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return R * c;
    }

    public static void main(String[] args) {
        if (args.length > 0) {
            new Main(args[0]);
        } else {
            new Main("wading-pools-filtered.json");
        }
    }
}
