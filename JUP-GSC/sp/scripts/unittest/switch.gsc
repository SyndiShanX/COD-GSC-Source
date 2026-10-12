/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\switch.gsc
***********************************************/



#using scripts\unittest\util;
#namespace unittest_switch;

function switch_case() {
  numcases = [2, 1, 4, 3, 0];

  foreach(c in numcases) {
    switch (c) {
      case 0:
        test_print("number 0");
        break;
      case 1:
        test_print("number 1");
        break;
      case 2:
        test_print("number 2");
        break;
      case 3:
        test_print("number 3");
        break;
    }
  }

  strcases = ["b", "a", "foo", "d", "c"];

  foreach(c in strcases) {
    switch (c) {
      case #"hash_31103fbc01bd840c":
        test_print("string a");
        break;
      case #"hash_311042bc01bd88c5":
        test_print("string b");
        break;
      case #"hash_311041bc01bd8732":
        test_print("string c");
        break;
      case #"hash_31103cbc01bd7f53":
        test_print("string d");
        break;
      case #"hash_7038dec66d8275be":
        test_print("string default: " + c);
        break;
    }
  }

  mixedcases = ["a", 2, 0, "foo", "b", 1];

  foreach(c in mixedcases) {
    switch (c) {
      case #"hash_31103fbc01bd840c":
        test_print("mixed a");
        break;
      case 0:
        test_print("mixed 0");
        break;
      case #"hash_311042bc01bd88c5":
        test_print("mixed b");
        break;
      case #"hash_31100fbc01bd387c":
        test_print("mixed 1");
        break;
      default:
        test_print("mixed default: " + c);
        break;
    }
  }

  skipcases = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  foreach(c in skipcases) {
    switch (c) {
      case 0:
      case 1:
        test_print("skip 0: " + c);
        break;
      case 2:
      case 3:
        if(c % 1) {
          x = 1;
        } else {
          x = 0;
        }

        test_print("skip 1: " + c + " x: " + x);
      case 4:
        test_print("skip 1.1: " + c);
        break;
      case 5:
      case 6:
      default:
        test_print("skip 2: " + c);
        break;
    }
  }

  var_5fd7177feb6ad53 = [0, 1, 2, 3, 4, 5, 6, 7];

  foreach(c in var_5fd7177feb6ad53) {
    switch (c) {
      case 0:
      case 1:
      case 2:
      case 3:
        test_print("combine 1: " + c);
        break;
      case 4:
      case 5:
      default:
        test_print("combine 2: " + c);
        break;
    }
  }

  var_5fd7177feb6ad53 = ["foo_a", "foo_b", "foo_c", "foo_d"];

  foreach(c in var_5fd7177feb6ad53) {
    switch (c) {
      case #"hash_bec7864bdc9acd1b":
      case #"hash_bec7874bdc9aceae":
      case #"hash_bec7884bdc9ad041":
        test_print("combine str: " + c);
        break;
    }
  }

  singlecases = [0, 1, 2, 3];

  foreach(c in singlecases) {
    switch (c) {
      default:
        test_print("single: " + c);
        break;
    }
  }

  singlecases = ["foo_a", "foo_b", "foo_c", "foo_d"];

  foreach(c in singlecases) {
    switch (c) {
      case #"hash_bec7874bdc9aceae":
        test_print("single_str: " + c);
        break;
    }
  }
}

function switch_nest() {
  test_print("switch_nest");
  numcases = [0, 0, 0, 1, 0, 2, 1, 0, 1, 1, 1, 2];
  i = 0;

  while(i < numcases.size) {
    c0 = numcases[i];
    c1 = numcases[i + 1];

    switch (c0) {
      case 0:
        switch (c1) {
          case 0:
            test_print("nest 0 0");
            break;
          case 1:
            test_print("nest 0 1");
            break;
          case 2:
            test_print("nest 0 2");
            break;
        }

        break;
      case 1:
        switch (c1) {
          case 0:
            test_print("nest 1 0");
            break;
          case 1:
            test_print("nest 1 1");
            break;
          case 2:
            test_print("nest 1 2");
            break;
        }

        break;
      default:
        test_print("nest bad");
        break;
    }

    i += 2;
  }
}

function switch_loop() {
  for(i = 0; i < 10; i++) {
    switch (i) {
      case 0:
        for(j = 0; j < 5; j++) {
          if(j > 2) {
            break;
          }
        }

        test_print("switch_loop: " + j);
        break;
      default:
        break;
    }
  }
}

function main() {
  test_begin("Switch");
  switch_case();
  switch_nest();
  switch_loop();
  test_end("Switch");
}