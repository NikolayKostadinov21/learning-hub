# Quadratic Voting

This repository contains two Noir circuits designed to implement and enforce quadratic voting mechanisms. Quadratic voting allows participants to allocate votes in a way that the cost of each additional vote for a candidate grows quadratically, encouraging more balanced decision-making.

## Circuit 1: Quadratic Vote Validation and Commitment

Overview

This circuit validates the votes of a single voter against a predefined token budget using the quadratic cost function. It also calculates a cryptographic commitment for the voter's ballot.
### Inputs

    secret (Field): A secret value used to protect the commitment from brute-force attacks.

    token_budget (pub u32): The maximum number of tokens the voter is allowed to use.

    votes ([u32; CANDIDATE_COUNT]): An array representing the number of votes allocated to each candidate.

### Outputs

    commitment (Field): The cryptographic commitment to the ballot, calculated using a Pedersen hash.

## Functions

    check_within_budget(votes: [u32; CANDIDATE_COUNT], token_budget: u32)
        Validates that the sum of the squared votes does not exceed the specified token budget.

    calculate_ballot_commitment(secret: Field, votes: [u32; CANDIDATE_COUNT]) -> Field
        Computes a cryptographic commitment for the ballot using the voter's secret and the vote allocations.

    main(secret: Field, token_budget: pub u32, votes: [u32; CANDIDATE_COUNT]) -> Field
        Enforces the quadratic voting rules and returns the ballot commitment.

## Circuit 2: Aggregate Vote Tallying with Commitment Verification

### Overview

This circuit aggregates the votes from multiple voters while ensuring that each voter's ballot matches their prior public commitments. This prevents tampering and ensures consistency with previously made commitments.
### Inputs

    commitments (pub [Field; VOTER_COUNT]): An array of public commitments for each voter's ballot.

    all_votes ([u32; VOTER_COUNT * CANDIDATE_COUNT]): A flattened 2D array representing each voter's votes.
    
    secrets ([Field; VOTER_COUNT]): An array of secrets used by each voter to protect their ballot commitments.

### Outputs

    totals (pub [u32; CANDIDATE_COUNT]): An array representing the aggregated vote totals for each candidate.

### Functions

    check_commitments(commitments: [Field; VOTER_COUNT], secrets: [Field; VOTER_COUNT], all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT])
        Verifies that each voter's votes are consistent with their prior commitments.

    sum_votes(all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT]) -> [u32; CANDIDATE_COUNT]
        Aggregates the votes for each candidate from all voters.

    main(commitments: pub [Field; VOTER_COUNT], all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT], secrets: [Field; VOTER_COUNT]) -> pub [u32; CANDIDATE_COUNT]
        Checks the commitments and sums the votes, returning the final aggregated totals.


### Dependencies

These circuits rely on the std library provided by Noir for cryptographic operations such as the Pedersen hash.


### Compilation and Execution

To compile and execute these circuits, ensure you have the Noir environment set up on your system. Follow the Noir documentation for detailed instructions on compilation and execution.