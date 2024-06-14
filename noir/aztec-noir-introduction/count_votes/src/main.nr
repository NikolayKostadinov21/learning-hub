use dep::std;

global CANDIDATE_COUNT = 10;
global VOTER_COUNT = 2;

fn check_commitments(
    // Each user's existing commitment to match
    commitments: [Field; VOTER_COUNT],
    // Each user's ballot secret
    secrets: [Field; VOTER_COUNT],
	all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT],
) {
	for i in 0..VOTER_COUNT {
		let mut transcript = [0; CANDIDATE_COUNT + 1];
        transcript[0] = secrets[i];
		for j in 0..CANDIDATE_COUNT {
			// Pedersen expects a transscript of Field elements, hence the cast
			transcript[j + 1] = all_votes[i * CANDIDATE_COUNT + j] as Field;
		};
		assert (commitments[i] == std::hash::pedersen_hash(transcript));
	};
}

fn sum_votes(
	all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT]
) -> [u32; CANDIDATE_COUNT] {
	// Sums of each "column" get aggregated into this array
	let mut totals = [0; CANDIDATE_COUNT];
	for i in 0..VOTER_COUNT {
		for j in 0..CANDIDATE_COUNT {
			totals[j] = totals[j] + all_votes[i * CANDIDATE_COUNT + j];
		}
	};
	// Return the aggreagated totals
	totals
}

// Totals the votes for each candidate whilst checking that ballots
// are consistent with their prior commitments. The contents of each
// input array should follow a consistent user ordering.
fn main(
	// The public ballot commitments made by each voter
    commitments: pub [Field; VOTER_COUNT],
	// A flattened 2D array of each users' votes
    // Note: unflattened 2D array aren't yet supported by the ABI
	all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT],
	// Each user's ballot secret
    secrets: [Field; VOTER_COUNT],
) -> pub [u32; CANDIDATE_COUNT] {
	// Enforce prior commitments to prevent censorship or tampering
    check_commitments(commitments, secrets, all_votes);
    // Reveal the final result
    sum_votes(all_votes)
}
