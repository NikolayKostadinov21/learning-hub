use dep::std::hash::keccak256;


global HASHLEN = 32;
global PASSWORDLEN = 2;
fn main(password : [Field; 2], passwordHash : pub [u8; HASHLEN]) { 
    assert(passwordHash == keccak256([password[0] as u8, password[1] as u8], PASSWORDLEN)); 
}

#[test]
fn test_main() {
    let password = [1,2];
    let passwordHash = [
    34, 174, 109, 166, 180, 130, 249, 177,
    177, 155,  11, 137, 124,  63, 212,  56,
    132,  24,  10,  28,  94, 227,  97, 225,
    16, 122,  27, 198,  53, 100, 157, 218];
    main(password, passwordHash);
}
