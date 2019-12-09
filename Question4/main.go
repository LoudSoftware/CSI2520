package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"math"
	"math/rand"
	"strconv"
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

// Inspired from https://stackoverflow.com/questions/15802890/idiomatic-quicksort-in-go
func qsort(list []*Pool) []*Pool {
	if len(list) < 2 {
		return list
	}

	left, right := 0, len(list)-1

	// Pick a pivot
	pivotIndex := rand.Int() % len(list)

	// Move the pivot to the right
	list[pivotIndex], list[right] = list[right], list[pivotIndex]

	// Pile elements smaller than the pivot on the left
	for i := range list {
		if list[i].Coordinates[0] < list[right].Coordinates[0] {
			list[i], list[left] = list[left], list[i]
			left++
		}
	}

	// Place the pivot after the last smaller element
	list[left], list[right] = list[right], list[left]

	// Go down the rabbit hole
	qsort(list[:left])
	qsort(list[left+1:])

	return list
}

// Defining the Route struct
type Route struct {
	cumulativeDist float64
	pool           *Pool
}

// Finding distance between 2 Pools
func concurrentP2PDistance(p *Pool, other *Pool, out chan Route) {
	out <- Route{p.distance(other), other}
}

func (p *Pool) distance(other *Pool) (float64) {
	lat1 := p.Coordinates[0] * math.Pi / 180
	lon1 := p.Coordinates[1] * math.Pi / 180
	lat2 := other.Coordinates[0] * math.Pi / 180
	lon2 := other.Coordinates[1] * math.Pi / 180

	a := 2 * math.Asin(math.Sqrt(math.Pow(math.Sin((lat1-lat2)/2), 2) +
		math.Cos(lat1)*math.Cos(lat2)*math.Pow(math.Sin((lon1-lon2)/2), 2)))

	return 6371.0 * a
}

// Finding the closest point from the array to the given point
func findClosestPoint(pool *Pool, pools []*Pool) (*Pool, int) {
	out := make(chan Route, len(pools))

	for i := 0; i < len(pools); i++ {
		concurrentP2PDistance(pool, pools[i], out)
	}

	current := Route{math.MaxFloat64, nil}
	currentIndex := math.MaxInt64 // Making it so that the index is by default out of bounds
	for i := 0; i < len(pools); i++ {
		result := <-out
		if result.cumulativeDist < current.cumulativeDist {
			current = result
			currentIndex = i
		}
	}

	defer close(out)

	return current.pool, currentIndex
}


func findRoute(Tree []*Pool) ([]*Route) {
	var routeList []*Route

	for len(Tree) > 0 {
		// Initializing the routelist to contain the first element
		if len(routeList) == 0 {
			e := Tree[0]
			Tree = removeAtIndex(Tree, 0)
			routeList = append(routeList, &Route{0, e})
		} else { // Then we want for each last element added to routeList to sort the tree according to distance to the point

			var root = routeList[len(routeList)-1]                 // This is the root point from which we want the closest
			var closest, index = findClosestPoint(root.pool, Tree) // We get the closest point to the root with this
			Tree = removeAtIndex(Tree, index)                      // Because we silly people do this kinda horror

			//Calculate cumulative distance
			rootDist := root.cumulativeDist
			distToRoot := root.pool.distance(closest)

			routeList = append(routeList, &Route{rootDist + distToRoot, closest})
		}
	}
	return routeList

}

func removeAtIndex(s []*Pool, index int) []*Pool {
	s[len(s)-1], s[index] = s[index], s[len(s)-1]
	return s[:len(s)-1]
}

func saveRoute(route []*Route, filename string) (bool) {
	file, err := os.Create(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	defer file.Close()

	for _, routePoint := range route {
		out := routePoint.pool.Name + " " + strconv.FormatFloat(routePoint.cumulativeDist, 'f', -1, 64) + "\n"
		file.WriteString(out)
	}
	return true
}

func main() {
	pools := getPools()

	sortedPools := qsort(pools)

	fmt.Println("Sorted from west to east...")

	route := findRoute(sortedPools)

	fmt.Println("Current Route...")
	for _, p := range route {
		fmt.Printf("%s: %f\n", p.pool.Name, p.cumulativeDist)
	}

	saveRoute(route, "Result.txt")
}
