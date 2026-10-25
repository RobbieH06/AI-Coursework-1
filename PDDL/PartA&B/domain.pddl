(define (domain lunar)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        rover - object
        waypoint - object
        lander - object
        sample - object
        data - object
        image - data
        scan - data
    
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

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

    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

    (:action deploy
        :parameters (?r - rover ?l - lander ?w - waypoint)
        :precondition (and (aboard ?r) (roverLander ?r ?l) (landerLocation ?l ?w))
        :effect (and (not (aboard ?r))(roverLocation ?r ?w))
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
        :parameters (?r - rover ?l - lander ?s - sample ?w - waypoint)
        :precondition (and (roverLander ?r ?l) (landerLocation ?l ?w) (roverLocation ?r ?w) (roverSample ?r ?s) (landerEmpty ?l))
        :effect (and (not (roverSample ?r ?s)) (noSample ?r)(not (landerEmpty ?l)) (sampleStored ?l ?s))
    )
    
    (:action scan
        :parameters (?r - rover ?d - scan ?w - waypoint)
        :precondition (and (roverLocation ?r ?w) (dataLocation ?d ?w) (noData ?r))
        :effect (and (not (dataLocation ?d ?w))(not (noData ?r))(roverData ?r ?d))
    )

    (:action storeData
        :parameters (?r - rover ?l - lander ?d - data)
        :precondition (and (roverLander ?r ?l) (roverData ?r ?d))
        :effect (and (not (roverData ?r ?d)) (noData ?r) (dataStored ?l ?d))
    )

    (:action captureImage
        :parameters (?r - rover ?d - image ?w - waypoint)
        :precondition (and (roverLocation ?r ?w) (dataLocation ?d ?w) (noData ?r))
        :effect (and (not (dataLocation ?d ?w)) (not (noData ?r)) (roverData ?r ?d))
    )

)
