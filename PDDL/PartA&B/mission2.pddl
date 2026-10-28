(define (problem lunar-mission-2)
    (:domain lunar)

    (:objects
        rover1 - rover
        lander1 - lander
        rover2 - rover
        lander2 - lander
        wp1 wp2 wp3 wp4 wp5 wp6 - waypoint
        imgWp2 - image
        imgWp3 - image
        scanWp4 - scan
        scanWp6 - scan
        sampleWp1 - sample
        sampleWp5 - sample
    )

    (:init
        (roverLander rover1 lander1)
        (roverLander rover2 lander2)
        (roverLocation rover1 wp2)
        (landerLocation lander1 wp2)
        (landerLocation lander2 wp6)
        (aboard rover2)

        (noData rover1)
        (noSample rover1)
        (noData rover2)
        (noSample rover2)
        (landerEmpty lander1)
        (landerEmpty lander2)

        (waypointPath wp1 wp2) (waypointPath wp2 wp1)
        (waypointPath wp2 wp4) (waypointPath wp4 wp2)
        (waypointPath wp2 wp3)
        (waypointPath wp3 wp5) (waypointPath wp5 wp3)
        (waypointPath wp5 wp6)
        (waypointPath wp6 wp4)

        (dataLocation imgWp2 wp2)
        (dataLocation imgWp3 wp3)
        (dataLocation scanWp4 wp4)
        (dataLocation scanWp6 wp6)
        (sampleLocation sampleWp1 wp1)
        (sampleLocation sampleWp5 wp5)

    )

    (:goal
        (and
            (dataStored lander1 imgWp3)
            (dataStored lander1 scanWp6)
            (sampleStored lander1 sampleWp5)
            (dataStored lander2 imgWp2)
            (dataStored lander2 scanWp4)
            (sampleStored lander2 sampleWp1)
        )
    )
)