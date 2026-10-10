/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\factions.gsc
***********************************************/

#namespace factions;

function function_33a7fdfb8c2962c2(var_3becae425c4ce1a) {
  switch (var_3becae425c4ce1a) {
    case #"hash_d5db7454b6a73a3d":
      return % "hash_2912cdcd8500fd39";
    case #"hash_d56d8529d86b9c8d":
      return % "hash_32f9ded8ec3513a9";
    case #"hash_7e32e56cd23412de":
      return % "hash_27e4b194c2f69712";
    case #"hash_de67d44ee82442a5":
      return % "hash_406a35c7493322c9";
    case #"hash_16af78da11bad4f5":
      return % "hash_40d8ba6cede8bd89";
    case #"hash_7e4b9c6cd24727ab":
      return % "hash_27ffb894c30d6aaf";
    case #"hash_6182550308f4c7e":
      return % "hash_2a7b8282dfdbde62";
    case #"hash_f018b7d9fd1b813b":
      return % "hash_3edd35c062c8fab7";
    case #"hash_11df5148f28c039e":
      return % "hash_2f2fd225a8f5a81a";
    case #"hash_aec089865f37db9e":
      return % "hash_416acb13f2e5e512";
    case #"hash_6151370d8d0dafbd":
      return % "hash_150a4106431dfa41";
    case #"hash_253aa9d445fc8bc7":
      return % "hash_710d9361a6e6c0cb";
    case #"hash_7c5bf7a68363dccd":
      return % "hash_7e61310f79005eb9";
    case #"hash_5c446d57f7386b1a":
      return % "hash_6789054811978ea6";
    case #"hash_9fd0f55b9933d9b1":
      return % "hash_3199b81a03b226d";
    case #"hash_44348bf9c79415c9":
      return % "hash_7bd15ead9a608835";
    case #"hash_6f9f46e0d354a7e3":
      return % "hash_6a00fc01918329b7";
    case #"hash_e1df00fac0b78d5c":
      return % "hash_796ab27845e4739a";
    case #"hash_2892a50b525254f1":
      return % "hash_40df5c33e4962889";
    case #"hash_9b5058cbb64f5c19":
      return % "hash_6a3e9234e0d7e26d";
    case #"hash_61d85e6b18faf229":
      return % "hash_6c6d4787c13b5ffd";
    case #"hash_f88271914675e646":
      return % "hash_23293db41dcbffa9";
    case #"hash_332a13e51c2db6b1":
      return % "hash_46a72ee8b11489b5";
  }

  assertmsg("Could not lookup bundle for legacy CSV faction " + var_3becae425c4ce1a);
  return % "hash_27e4b194c2f69712";
}

function function_716b04a356073ae5(var_3becae425c4ce1a) {
  return getscriptbundle(function_33a7fdfb8c2962c2(var_3becae425c4ce1a));
}