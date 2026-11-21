@nearest
Feature: Nearest API - node IDs in response

    Background:
        Given the profile "testbot"

    Scenario: Nearest - one-way road snap at start returns valid non-zero node IDs
        Given the node map
            """
            0 a x b
            """

        And the ways
            | nodes | oneway |
            | axb   | yes    |

        When I request nearest I should get
            | in | out | nodes |
            | 0  | a   | a,x   |

    Scenario: Nearest - one-way road segment node IDs
        Given the node map
            """
            a 0 x 1 y 2 b
            """
        And the ways
            | nodes | oneway |
            | axyb  | yes    |
        When I request nearest I should get
            | in | out | nodes |
            | 0  | 0   | a,x   |
            | 1  | 1   | x,y   |
            | 2  | 2   | y,b   |

    Scenario: Nearest - reverse one-way road segment node IDs
        Given the node map
            """
            a 0 x 1 y 2 b
            """
        And the ways
            | nodes | oneway |
            | axyb  | -1     |
        When I request nearest I should get
            | in | out | nodes |
            | 0  | 0   | x,a   |
            | 1  | 1   | y,x   |
            | 2  | 2   | b,y   |

    Scenario: Nearest - two-way road segment node IDs
        Given the node map
            """
            a 0 x 1 y 2 b
            """
        And the ways
            | nodes |
            | axyb  |
        When I request nearest I should get
            | in | out | nodes |
            | 0  | 0   | x,a   |
            | 1  | 1   | y,x   |
            | 2  | 2   | b,y   |

    Scenario: Nearest - one-way segment node IDs in FlatBuffers
        Given the node map
            """
            a 0 x 1 y 2 b
            """
        And the ways
            | nodes | oneway |
            | axyb  | yes    |
        When I request nearest with flatbuffers I should get
            | in | out | nodes |
            | 0  | 0   | a,x   |
            | 1  | 1   | x,y   |
            | 2  | 2   | y,b   |

