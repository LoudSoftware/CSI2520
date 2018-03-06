/*
 * Copyright (c) 2018. Nicolas Znamenski
 */

package com.question1.model;


import java.util.ArrayList;


@SuppressWarnings("unused")
public class WadingPool implements Comparable<WadingPool> {
    // Node attributes
    private WadingPool parent;
    private WadingPool left;
    private WadingPool right;

    //Properties loaded from JSON
    private String name;
    private ArrayList<Double> coordinates;
    private double cumulativeDistance;

    // Getters
    public WadingPool getParent() {
        return parent;
    }

    public WadingPool getLeft() {
        return left;
    }

    public WadingPool getRight() {
        return right;
    }

    public String getName() {
        return name;
    }

    public ArrayList<Double> getCoordinates() {
        return coordinates;
    }

    public double getCumulativeDistance() {
        return cumulativeDistance;
    }

    // Setters
    public void setParent(WadingPool parent) {
        this.parent = parent;
    }

    public void setLeft(WadingPool left) {
        this.left = left;
    }

    public void setRight(WadingPool right) {
        this.right = right;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCoordinates(ArrayList<Double> coordinates) {
        this.coordinates = coordinates;
    }

    public void setCumulativeDistance(double cumulativeDistance) {
        this.cumulativeDistance = cumulativeDistance;
    }

    /**
     * @param o the object to be compared.
     * @return a negative integer, zero, or a positive integer as this object
     * is less than, equal to, or greater than the specified object.
     * @throws NullPointerException if the specified object is null
     * @throws ClassCastException   if the specified object's type prevents it
     *                              from being compared to this object.
     */
    public int compareTo(WadingPool o) {
        int result;
        if (this.coordinates.get(1) <= o.coordinates.get(1)) {
            result = -1;
        } else {
            result = 1;
        }
        return result;
    }

    @Override
    public String toString() {
        return "WadingPool{" +
                "parent=" + parent +
                ", left=" + left +
                ", right=" + right +
                ", name='" + name + '\'' +
                ", coordinates=" + coordinates.toString() +
                '}';
    }
}

