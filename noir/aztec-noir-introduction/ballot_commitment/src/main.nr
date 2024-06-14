use dep::std;
global CANDIDATE_COUNT = 10;
fn calculate_ballot_commitment(
	votes: [u32; CANDIDATE_COUNT],
	secret: Field
) -> Field {
	// Form the transcript by prepending the votes with the secret.
	// Note: In the future it will be possible to size this array
	// more flexibly with the use of comptime expressions.
	let mut transcript = [0; CANDIDATE_COUNT + 1];
	transcript[0] = secret;
	for i in 0..CANDIDATE_COUNT {
		// Pedersen expects a transcript of Field elements, hece the cast
		transcript[i + 1] = votes[i] as Field;
	};
	//Return the x coordinate of the resulting EC point
	std::hash::pedersen_hash(transcript)
}

// Performed by a user who whishes to hide their ballot while proving
// that they have obeyed the rules of QV.
fn main(votes: [u32; CANDIDATE_COUNT], secret: Field) -> pub Field {
    // Reveal the commitment
	calculate_ballot_commitment(votes, secret)
}

