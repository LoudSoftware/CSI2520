import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import model.WadingPool; // Our wading pool model

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class Main {
    private final String filename;
    private Gson gson;
    private static final Type wadingPoolType = new TypeToken<List<WadingPool>>(){}.getType();
    private List<WadingPool> data = new ArrayList<WadingPool>(100);

    private Main(String filename) {
        this.filename = filename;
        this.gson = new Gson();
        JsonReader reader;

        // Try to read the file
        try {
            reader = new JsonReader(new FileReader(filename));
            data = gson.fromJson(reader, wadingPoolType);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        // Printing the pools
        System.out.println("Found " + data.size() + " Wading pools in json, printing them now");
        for (WadingPool pool :
                data) {
            System.out.println(pool);
        }
    }

    public static void main(String[] args) {
        if (args.length > 0){
            new Main(args[0]);
        } else {
            new Main("wading-pools-filtered.json");
        }
    }
}
