/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ping_shared.csc
***********************************************/

#namespace ping;

function function_fed6948(type) {
  switch (type) {
    case 3:
    case 6:
    case 7:
    case 11:
      return -1;
    case 1:
    case 2:
    case 10:
      return -2;
  }

  return undefined;
}

function function_5947d757(type) {
  return isDefined(function_fed6948(type)) ? function_fed6948(type) : type;
}

function function_44806bba(type) {
  pool = function_5947d757(type);

  if(pool == -1) {
    return getdvarint(#"hash_135ab15dc980084b", 2);
  } else if(pool == -2) {
    return getdvarint(#"hash_5ef51cd5a0446de9", 2);
  } else if(pool == 0) {
    return getdvarint(#"hash_4b0a67e50aeacdee", 1);
  } else if(pool == 4) {
    return getdvarint(#"hash_4685d89a104a6860", 1);
  } else if(pool == 5) {
    return getdvarint(#"hash_60e62eecbe40e4ee", 1);
  } else if(pool == 8 || pool == 9) {
    return getdvarint(#"hash_37085d816592dbe3", 2);
  } else if(pool == 12) {
    return getdvarint(#"hash_37085d816592dbe3", 2);
  } else {
    assertmsg("<dev string:x38>" + type + "<dev string:x69>" + pool + "<dev string:x76>");
  }

  return 1;
}