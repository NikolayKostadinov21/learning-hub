global VOTER_COUNT = 2;
global CANDIDATE_COUNT = 10;
fn check_commitments(
	all_votes: [u32; CANDIDATE_COUNT],
	secrets: [Field; VOTER_COUNT],
	commitments: [Field; VOTER_COUNT]
){
	for i in 0..VOTER_COUNT {
		let mut transcript = [0; CANDIDATE_COUNT + 1];
		transcript[0] = secrets[i]
		for j in 0..CANDIDATE_COUNT {
			transcript[j + 1] = all_votes[i * CANDIDATE_COUNT + j] as Field;
		}
	assert(commitments[i] == std::hash::pedersen(transcript)[0]);
	};
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
