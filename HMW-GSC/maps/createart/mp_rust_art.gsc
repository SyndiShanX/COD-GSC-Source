main() {
  level.tweakfile = 1;

  if(isusinghdr()) {
    maps\createart\mp_rust_fog_hdr::main();
  } else {
    maps\createart\mp_rust_fog::main();
  }

  visionsetnaked("mp_rust", 0);
}