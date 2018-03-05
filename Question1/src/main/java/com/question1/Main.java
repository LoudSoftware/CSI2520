/*
 * Copyright (c) 2018. Nicolas Znamenski
 */

package com.question1;import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.question1.model.WadingPool; // Our wading pool model
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;


public class Main {
    private final String filename;
    private Gson gson;
    private static final Type wadingPoolType = new TypeToken<List<WadingPool>>(){}.getType();
    private List<WadingPool> data = new ArrayList<WadingPool>(100);
    private JsonReader reader;

    private Main(String filename) {
        this.filename = filename;

        /**
         * Grabs the data and puts it in data
         */
        getData();

        data.sort(Comparator.naturalOrder()); //Sorting from west-most to east-most
        for (WadingPool pool :
                data) {
            System.out.println(pool);
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

        double R = 6371e3; // metres
        double f1 = Math.toRadians(lat1);
        double f2 = Math.toRadians(lat2);
        double df = Math.toRadians(lat2-lat1);
        double dl = Math.toRadians(lon2-lon1);

        double a = Math.sin(df/2) * Math.sin(df/2) +
                Math.cos(f1) * Math.cos(f2) *
                        Math.sin(dl/2) * Math.sin(dl/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

        double d = R * c;
        return d;
    }

    public static void main(String[] args) {
        if (args.length > 0){
            new Main(args[0]);
        } else {
            new Main("wading-pools-filtered.json");
        }
    }
}
