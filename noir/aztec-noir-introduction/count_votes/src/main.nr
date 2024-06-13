global CANDIDATE_COUNT = 10;
global VOTER_COUNT = 2;

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

fn main(
	all_votes: [u32; VOTER_COUNT * CANDIDATE_COUNT]
) -> pub [u32; CANDIDATE_COUNT] {
    sum_votes(all_votes)
}

#[test]
fn test_main() {
    let CANDIDATE_COUNT = 10;
    let VOTER_COUNT = 2;
    let all_votes: [u32; CANDIDATE_COUNT * VOTER_COUNT] = [0,0,0,0,0,0,10,0,0,0,5,3,2,0,0,0,0,0,6,3];

    main(all_votes);
}
