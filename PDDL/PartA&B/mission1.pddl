(define (problem lunar-mission-1)
    (:domain lunar)

    (:objects
        rover1 - rover
        lander1 - lander
        wp1 wp2 wp3 wp4 wp5 - waypoint
        imgWp5 - image
        scanWp3 - scan
        sampleWp1 - sample
    )

    (:init
       (roverLander rover1 lander1)
       (landerLocation lander1 wp2)
       (aboard rover1)

       (noData rover1)
       (noSample rover1)
       (landerEmpty lander1)

       (waypointPath wp1 wp2)
       (waypointPath wp2 wp3)
       (waypointPath wp3 wp5)
       (waypointPath wp5 wp1)
       (waypointPath wp1 wp4)
       (waypointPath wp4 wp3) 

       (dataLocation imgWp5 wp5)
       (dataLocation scanWp3 wp3)
       (sampleLocation sampleWp1 wp1)
    )

    (:goal
        (and
            (sampleStored lander1 sampleWp1)
            (dataStored lander1 imgWp5)
            (dataStored lander1 scanWp3)
            
        )
    )
)