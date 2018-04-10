package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"math"
)

//Pool Defining a pool struct
type Pool struct {
	Name        string    `json:"name"`
	Coordinates []float64 `json:"coordinates"`
}

func (p Pool) toString() string {
	return toJSON(p)
}

func toJSON(p interface{}) string {
	bytes, err := json.Marshal(p)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	return string(bytes)
}

func getPools() ([]*Pool) {
	raw, err := ioutil.ReadFile("./wading-pools-filtered.json")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	var l []*Pool
	json.Unmarshal(raw, &l)
	return l
}

// Sorting from westmost to eastmost point
func qsortPass(arr []*Pool, stop chan int) []*Pool {

	if len(arr) < 2 {
		stop <- len(arr)
		return arr
	}

	pivot := arr[0]
	i, j := 1, len(arr)-1

	for i != j {
		for arr[i].Coordinates[0] < pivot.Coordinates[0] && i != j {
			i++
		}
		for arr[j].Coordinates[0] >= pivot.Coordinates[0] && i != j {
			j--
		}
		if arr[i].Coordinates[0] > arr[j].Coordinates[0] {
			arr[i], arr[j] = arr[j], arr[i]
		}
	}

	if arr[j].Coordinates[0] >= pivot.Coordinates[0] {
		j--
	}
	arr[0], arr[j] = arr[j], arr[0]

	stop <- 1

	go qsortPass(arr[:j], stop)
	go qsortPass(arr[j+1:], stop)

	return arr
}
func qsort(arr []*Pool) []*Pool {

	stop := make(chan int)

	defer func() {
		close(stop)
	}()

	go qsortPass(arr[:], stop)

	results := len(arr)

	for results > 0 {
		results -= <-stop
	}

	return arr
}

// Defining the Route struct
type Route struct {
	cumulativeDist float64
	pool           *Pool
}

// Finding distance between 2 Pools
func p2pDistance(p *Pool, other *Pool, out chan Route) {
	out <- Route{p.distance(other), other}
}

func (p *Pool) distance(other *Pool) (float64) {
	lat1R := p.Coordinates[0] * math.Pi / 180
	lon1R := p.Coordinates[1] * math.Pi / 180
	lat2R := other.Coordinates[0] * math.Pi / 180
	lon2R := other.Coordinates[1] * math.Pi / 180

	dRad := 2 * math.Asin(math.Sqrt(math.Pow(math.Sin((lat1R-lat2R)/2), 2) +
		math.Cos(lat1R)*math.Cos(lat2R)*math.Pow(math.Sin((lon1R-lon2R)/2), 2)))

	return 6371.0 * dRad
}

//Finding the closest point from the array to the given point
func findClosestPoint(pool *Pool, pools []*Pool) (*Pool) {

	out := make(chan Route, 1000)

	for i := 0; i < len(pools); i++ {
		p2pDistance(pool, pools[i], out)
	}

	current := Route{math.MaxFloat64, nil}

	for i := 0; i < len(pools); i++ {

		result := <-out

		if result.cumulativeDist < current.cumulativeDist {
			current = result
		}
	}

	defer close(out)

	return current.pool
}

var Tree []*Pool

func getPath(Tree []*Pool) ([]*Route) {
	var routeList []*Route

	if Tree[0] == nil {
		e := Tree[0]
		remove(Tree, 0)
		fmt.Println(len(Tree))

		routeList = append(routeList, &Route{0, e})
	} else {

	}
	return routeList

}



func remove(s []*Pool, i int) []*Pool {
	s[len(s)-1], s[i] = s[i], s[len(s)-1]
	return s[:len(s)-1]
}

func main() {
	pools := getPools()
	/* for _, p := range pools {
		fmt.Println(p.toString())
	} */

	sortedPools := qsort(pools)

	fmt.Println("Sorted from west to east...")
	for _, p := range sortedPools {
		fmt.Println(p.toString())
	}

	route := getPath(sortedPools)
    fmt.Println(route)
	//fmt.Println(toJSON(pools))
}
