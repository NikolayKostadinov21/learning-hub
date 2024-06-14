use dep::std;
global CANDIDATE_COUNT = 10;

// Constrains votes to obey quadratic votes cost function
fn check_within_budget(votes: [u32; CANDIDATE_COUNT], token_budget: u32) {
	// Sum squared votes into this variable
	let mut tokens_spent: u32 = 0;
	// Loop over the vote for each candidate
	for i in 0..CANDIDATE_COUNT {
		let vote = votes[i];
		// Accumulate each squared vote
		tokens_spent = tokens_spent + (vote * vote);
	};

	// Check we haven't used more tokens than allowed
	assert (tokens_spent <= token_budget, "You are attempting to use more tokens than the allowed!");
}

fn calculate_ballot_commitment(secret: Field, votes: [u32; CANDIDATE_COUNT]) -> Field {
	// Form the transcript by prepending the votes with the secret
    // Note: In the future it will be possible to size this array
    // more flexibly with the use of comptime expressions.
	let mut transcript = [0; CANDIDATE_COUNT + 1];
	transcript[0] = secret;
	for i in 0..CANDIDATE_COUNT {
		// Pedersen expects a transcript of Field elements, hence the cast
		transcript[i + 1] = votes[i] as Field;
	}

	// Returns the x coordinate of the EC point
	std::hash::pedersen_hash(transcript)
}

fn main(
	// For shielding the commitment from brute-force attacks
	secret: Field,
	// Budget to be enforced
	token_budget: pub u32,
    // The votes for each candidate (identified by index)
    votes: [u32; CANDIDATE_COUNT],
) -> pub Field {
	// Enforce QV rules
	check_within_budget(votes, token_budget);
	// Reveal the commitment
	calculate_ballot_commitment(secret, votes)
}
