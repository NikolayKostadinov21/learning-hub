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
	constain tokens_spent <= token_budget;
}

fn main(x: Field, y: pub Field) {
    assert(x != y);
}

#[test]
fn test_main() {
    main(1, 2);

    // Uncomment to make test fail
    // main(1, 1);
}
