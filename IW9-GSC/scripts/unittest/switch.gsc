/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\switch.gsc
***********************************************/

switch_case() {
  _id_CE5805B01262AE30 = [2, 1, 4, 3, 0];

  foreach(c in _id_CE5805B01262AE30) {
    switch (c) {
      case 0:
        scripts\unittest\util::test_print("number 0");
        break;
      case 1:
        scripts\unittest\util::test_print("number 1");
        break;
      case 2:
        scripts\unittest\util::test_print("number 2");
        break;
      case 3:
        scripts\unittest\util::test_print("number 3");
        break;
    }
  }

  _id_60BAAC5A33171D69 = ["b", "a", "foo", "d", "c"];

  foreach(c in _id_60BAAC5A33171D69) {
    switch (c) {
      case "a":
        scripts\unittest\util::test_print("string a");
        break;
      case "b":
        scripts\unittest\util::test_print("string b");
        break;
      case "c":
        scripts\unittest\util::test_print("string c");
        break;
      case "d":
        scripts\unittest\util::test_print("string d");
        break;
      case "default":
        scripts\unittest\util::test_print("string default: " + c);
        break;
    }
  }

  _id_D00B61B1F0E46841 = ["a", 2, 0, "foo", "b", 1];

  foreach(c in _id_D00B61B1F0E46841) {
    switch (c) {
      case "a":
        scripts\unittest\util::test_print("mixed a");
        break;
      case 0:
        scripts\unittest\util::test_print("mixed 0");
        break;
      case "b":
        scripts\unittest\util::test_print("mixed b");
        break;
      case "1":
        scripts\unittest\util::test_print("mixed 1");
        break;
      default:
        scripts\unittest\util::test_print("mixed default: " + c);
        break;
    }
  }

  _id_4532B9E018851EC3 = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  foreach(c in _id_4532B9E018851EC3) {
    switch (c) {
      case 1:
      case 0:
        scripts\unittest\util::test_print("skip 0: " + c);
        break;
      case 3:
      case 2:
        if(c % 1)
          x = 1;
        else
          x = 0;

        scripts\unittest\util::test_print("skip 1: " + c + " x: " + x);
      case 4:
        scripts\unittest\util::test_print("skip 1.1: " + c);
        break;
      case 6:
      case 5:
      default:
        scripts\unittest\util::test_print("skip 2: " + c);
    }
  }

  _id_05FD7177FEB6AD53 = [0, 1, 2, 3, 4, 5, 6, 7];

  foreach(c in _id_05FD7177FEB6AD53) {
    switch (c) {
      case 3:
      case 2:
      case 1:
      case 0:
        scripts\unittest\util::test_print("combine 1: " + c);
        break;
      case 5:
      case 4:
      default:
        scripts\unittest\util::test_print("combine 2: " + c);
        break;
    }
  }

  _id_05FD7177FEB6AD53 = ["foo_a", "foo_b", "foo_c", "foo_d"];

  foreach(c in _id_05FD7177FEB6AD53) {
    switch (c) {
      case "foo_c":
      case "foo_b":
      case "foo_a":
        scripts\unittest\util::test_print("combine str: " + c);
        break;
    }
  }

  _id_01CEBE1079ED86B6 = [0, 1, 2, 3];

  foreach(c in _id_01CEBE1079ED86B6) {
    switch (c) {
      case 0:
        scripts\unittest\util::test_print("single: " + c);
        break;
    }
  }

  _id_01CEBE1079ED86B6 = ["foo_a", "foo_b", "foo_c", "foo_d"];

  foreach(c in _id_01CEBE1079ED86B6) {
    switch (c) {
      case "foo_b":
        scripts\unittest\util::test_print("single_str: " + c);
        break;
    }
  }
}

switch_nest() {
  scripts\unittest\util::test_print("switch_nest");
  _id_CE5805B01262AE30 = [0, 0, 0, 1, 0, 2, 1, 0, 1, 1, 1, 2];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CE5805B01262AE30.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
    c0 = _id_CE5805B01262AE30[_id_AC0E594AC96AA3A8];
    c1 = _id_CE5805B01262AE30[_id_AC0E594AC96AA3A8 + 1];

    switch (c0) {
      case 0:
        switch (c1) {
          case 0:
            scripts\unittest\util::test_print("nest 0 0");
            break;
          case 1:
            scripts\unittest\util::test_print("nest 0 1");
            break;
          case 2:
            scripts\unittest\util::test_print("nest 0 2");
            break;
        }

        break;
      case 1:
        switch (c1) {
          case 0:
            scripts\unittest\util::test_print("nest 1 0");
            break;
          case 1:
            scripts\unittest\util::test_print("nest 1 1");
            break;
          case 2:
            scripts\unittest\util::test_print("nest 1 2");
            break;
        }

        break;
      default:
        scripts\unittest\util::test_print("nest bad");
        break;
    }
  }
}

switch_loop() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    switch (_id_AC0E594AC96AA3A8) {
      case 0:
        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 5; _id_AC0E5C4AC96AAA41++) {
          if(_id_AC0E5C4AC96AAA41 > 2) {
            break;
          }
        }

        scripts\unittest\util::test_print("switch_loop: " + _id_AC0E5C4AC96AAA41);
        break;
      default:
    }
  }
}

main() {
  scripts\unittest\util::test_begin("Switch");
  switch_case();
  switch_nest();
  switch_loop();
  scripts\unittest\util::test_end("Switch");
}