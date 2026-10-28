(define (domain lunar-extended)
    (:requirements :strips :typing)

    (:types
        rover - object
        waypoint - object
        lander - object
        sample - object
        data - object
        image - data
        scan - data
        astronaut - object
        room - object
    )

    (:predicates
        (roverLocation ?r - rover ?w - waypoint)
        (landerLocation ?l - lander ?w - waypoint)
        (waypointPath ?w1 - waypoint ?w2 - waypoint)
        (roverSample ?r - rover ?s - sample)
        (roverData ?r - rover ?d - data)
        (roverLander ?r - rover ?l - lander)
        (aboard ?r - rover )
        (noData ?r - rover)
        (noSample ?r - rover)
        (sampleLocation ?s - sample ?w - waypoint)
        (landerEmpty ?l - lander)
        (sampleStored ?l - lander ?s - sample)
        (dataLocation ?d - data ?w - waypoint)
        (dataStored ?l - lander ?d - data)
        (astronautLocation ?a - astronaut ?rm - room)
        (astronautLander ?a - astronaut ?l - lander)
        (roomPath ?rm1 - room ?rm2 - room)
        (roomLander ?rm - room ?l - lander)
        (dockingBay ?rm - room)
        (controlRoom ?rm - room)
    )

    (:action deploy
        :parameters (?r - rover ?l - lander ?w - waypoint ?a - astronaut ?rm - room)
        :precondition (and (aboard ?r) (roverLander ?r ?l) (landerLocation ?l ?w) (astronautLander ?a ?l) (roomLander ?rm ?l) (dockingBay ?rm) (astronautLocation ?a ?rm))
        :effect (and (not (aboard ?r)) (roverLocation ?r ?w))
    )

    (:action move
        :parameters (?r - rover ?w1 - waypoint ?w2 - waypoint)
        :precondition (and (roverLocation ?r ?w1) (waypointPath ?w1 ?w2))
        :effect (and (not (roverLocation ?r ?w1))(roverLocation ?r ?w2))
    )

    (:action collectSample 
        :parameters (?r - rover ?s - sample ?w - waypoint)
        :precondition (and (roverLocation ?r ?w) (sampleLocation ?s ?w) (noSample ?r))
        :effect (and (not (sampleLocation ?s ?w))(not (noSample ?r))(roverSample ?r ?s))
    )

   (:action storeSample
        :parameters (?r - rover ?l - lander ?s - sample ?w - waypoint ?a - astronaut ?rm - room)
        :precondition (and (roverLander ?r ?l) (landerLocation ?l ?w) (roverLocation ?r ?w) (roverSample ?r ?s) (landerEmpty ?l) (astronautLocation ?a ?rm) (astronautLander ?a ?l))
        :effect (and (not (roverSample ?r ?s)) (noSample ?r)(not (landerEmpty ?l)) (sampleStored ?l ?s))
    )
    
    (:action scan
        :parameters (?r - rover ?d - scan ?w - waypoint)
        :precondition (and (roverLocation ?r ?w) (dataLocation ?d ?w) (noData ?r))
        :effect (and (not (dataLocation ?d ?w))(not (noData ?r))(roverData ?r ?d))
    )

    (:action storeData
        :parameters (?r - rover ?l - lander ?d - data ?a - astronaut ?rm - room)
        :precondition (and (roverLander ?r ?l) (roverData ?r ?d) (astronautLocation ?a ?rm) (astronautLander ?a ?l))
        :effect (and (not (roverData ?r ?d)) (noData ?r) (dataStored ?l ?d))
    )

    (:action captureImage
        :parameters (?r - rover ?d - image ?w - waypoint)
        :precondition (and (roverLocation ?r ?w) (dataLocation ?d ?w) (noData ?r))
        :effect (and (not (dataLocation ?d ?w)) (not (noData ?r)) (roverData ?r ?d))
    )

    (:action astronautMove
        :parameters (?a - astronaut ?rm1 - room ?rm2 - room ?l - lander)
        :precondition (and (astronautLander ?a ?l) (roomPath ?rm1 ?rm2) (astronautLocation ?a ?rm1))
        :effect(and (not (astronautLocation ?a ?rm1)) (astronautLocation ?a ?rm2))
    )

)