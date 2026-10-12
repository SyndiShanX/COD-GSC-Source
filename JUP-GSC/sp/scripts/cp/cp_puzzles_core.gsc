/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_puzzles_core.gsc
***********************************************/



#using script_489bc5ff08558a82;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_outline;
#using scripts\cp\interaction;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_puzzles_core;

function init() {
  level thread namespace_32bee385f5a24c28::init();
}

function init_binary_puzzle() {
  reroll_binary_op();
  flag_set("binary_puzzle_initialized");
  level thread updatecurrentoutput();
}

function reroll_binary_op() {
  level.escape_binary_sequence = calculatecorrectbinarysequence();
  level.current_cbreaker_sequence = "0_0_0_0";
  level.blocks_binary_sequence = calculatefourbitbinarysequence();
  level.current_blocks_sequence = level.blocks_binary_sequence;
  level.sequence_operator = determineoperation();
  assertex(isDefined(level.escape_binary_sequence), "The Sequence to escape the room isn't defined!!");
  assertex(isDefined(level.current_cbreaker_sequence), "The Current Circuit Breaker Sequence isn't defined!!");
  assertex(isDefined(level.blocks_binary_sequence), "The Blocks Binary Sequence isn't defined!!");
  assertex(isDefined(level.current_blocks_sequence), "The Current Blocks Binary Sequence isn't defined!!");
  assertex(isDefined(level.sequence_operator), "The Sequence Operator isn't defined!!");
  iprintln(" ^1 BINARY SEQUENCES AND OPERATIONS CHANGED!!! LOOK AGAIN!! ");
}

function updatecurrentoutput() {
  op = getdvarint(@ "hash_d889f30225b83fa5", 0);

  if(op != 0) {
    level.current_output = op;
  } else {
    level.current_output = performoperation(level.current_cbreaker_sequence, level.current_blocks_sequence, level.sequence_operator);
  }

  while(true) {
    level waittill("input_sequence_changed");
    op = getdvarint(@ "hash_d889f30225b83fa5", 0);

    if(op != 0) {
      level.current_output = op;
    } else {
      level.current_output = performoperation(level.current_cbreaker_sequence, level.current_blocks_sequence, level.sequence_operator);
    }

    var_4250e8f4232a71c5 = converttobinary(level.current_output, 1);
    iprintln(" ^1 BINARY VALUES FOR THE LAPTOPS - ^7" + var_4250e8f4232a71c5);
    var_1c3321f0f58f0e6c = strtok(var_4250e8f4232a71c5, "_");

    foreach(struct in level.cameraactivationstructs) {
      switch (struct.name) {
        case #"hash_b195b7771a2c2ac8":
          struct.bval = int(var_1c3321f0f58f0e6c[0]);
          break;
        case #"hash_b195ba771a2c2f81":
          struct.bval = int(var_1c3321f0f58f0e6c[1]);
          break;
        case #"hash_b195b9771a2c2dee":
          struct.bval = int(var_1c3321f0f58f0e6c[2]);
          break;
        case #"hash_b195bc771a2c32a7":
          struct.bval = int(var_1c3321f0f58f0e6c[3]);
          break;
      }
    }
  }
}

function determineoperation() {
  array = ["add", "sub", "and", "or", "xor"];
  choice = random(array);
  return choice;
}

function performoperation(var_23593744eb26db24, var_23593a44eb26e1bd, operator) {
  answer = 666;

  switch (operator) {
    case #"hash_c4e286c1095c786":
      answer = convertfrombinary(var_23593744eb26db24) &convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_fa2ad2f6bd6509e4":
      answer = convertfrombinary(var_23593744eb26db24) | convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_c3f1836c705d775e":
      answer = convertfrombinary(var_23593744eb26db24) ^ convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_c61546c10a51754":
      answer = convertfrombinary(var_23593744eb26db24) + convertfrombinary(var_23593a44eb26e1bd);

      if(answer >= 15) {
        answer = 15;
      }

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_9025ae6c553fd4f5":
      answer = convertfrombinary(var_23593744eb26db24) - convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_fa50baf6bd82f930":
      answer = convertfrombinary(var_23593744eb26db24) >> convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
    case #"hash_fa50b8f6bd82f60a":
      answer = convertfrombinary(var_23593744eb26db24) << convertfrombinary(var_23593a44eb26e1bd);

      if(answer <= 0) {
        answer = 0;
      }

      return answer;
  }
}

function calculatefourbitbinarysequence() {
  randint = randomintrange(1, 16);
  return converttobinary(randint, 1);
}

function calculatecorrectbinarysequence() {
  randint = randomintrange(1, 16);
  return converttobinary(randint, 1);
}

function converttobinary(digit, var_130c7170b6a041d4) {
  switch (digit) {
    case 0:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_0_0_0";
      }

      return "0_0_0";
    case 1:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_0_0_1";
      }

      return "0_0_1";
    case 2:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_0_1_0";
      }

      return "0_1_0";
    case 3:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_0_1_1";
      }

      return "0_1_1";
    case 4:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_1_0_0";
      }

      return "1_0_0";
    case 5:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_1_0_1";
      }

      return "1_0_1";
    case 6:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_1_1_0";
      }

      return "1_1_0";
    case 7:
      if(istrue(var_130c7170b6a041d4)) {
        return "0_1_1_1";
      }

      return "1_1_1";
    case 8:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_0_0_0";
      }
    case 9:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_0_0_1";
      }
    case 10:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_0_1_0";
      }
    case 11:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_0_1_1";
      }
    case 12:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_1_0_0";
      }
    case 13:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_1_0_1";
      }
    case 14:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_1_1_0";
      }
    case 15:
      if(istrue(var_130c7170b6a041d4)) {
        return "1_1_1_1";
      }

      assertex(istrue(var_130c7170b6a041d4), "^3YOU CANT REPRESENT ^6" + digit + " ^3WITH A 3 BIT NUMBER! ERROR IN SCRIPT - Aj ");
      break;
    default:
      iprintln(" you should not be getting this result. Error in Script - Aj ");
      break;
  }
}

function convertfrombinary(binary_sequence) {
  var_becbdfa822fd69e = strtok(binary_sequence, "_");
  one = int(var_becbdfa822fd69e[3]);
  two = int(var_becbdfa822fd69e[2]);
  four = int(var_becbdfa822fd69e[1]);
  eight = int(var_becbdfa822fd69e[0]);
  decimal_sequence = one * 1 + two * 2 + four * 4 + eight * 8;
  return decimal_sequence;
}

function getbinarysequencemapping() {
  array = ["f", "f_r", "r", "b_r", "b", "b_l", "l", "f_l"];
  var_69d32d6403bef4e0 = random(array);
  var_e0cf7acecab4470f = [];
  chosen = 0;
  counter = 0;
  var_2fe0c25b7c39977c = array;

  foreach(element in array) {
    var_e0cf7acecab4470f[element] = converttobinary(index);
  }

  return var_e0cf7acecab4470f;
}

function calculaterangeofprojectilemotion(u, var_450483a591a06439) {
  frange = squared(u) * sin(2 * var_450483a591a06439) / 19.62;
}

function init_block_puzzle_interaction() {
  scripts\cp\interaction::register_interaction("block_puzzle_interaction", "null", undefined, &blockpuzzlehint, &blockpuzzleactivation, 0, 0, &blockpuzzleinit);
  scripts\cp\interaction::register_interaction("view_operation_result", "null", undefined, &viewoperationhint, &viewoperationactivation, 0, 0, &viewoperationinit);
}

function viewoperationinit(structarray) {
  foreach(str in structarray) {
    str.model = spawn("script_model", str.origin);
    str.model setModel("button_on_green");

    if(isDefined(str.angles)) {
      str.model.angles = str.angles;
    }
  }
}

function viewoperationhint(interaction_struct, player) {
  return &"CP_LAB/VIEW_OP_RESULT";
}

function viewoperationactivation(interaction_struct, player) {
  player iprintln("^5 CURRENT RESULT WITH THE ^1 " + level.sequence_operator + "^5 OPERATOR IS- ^8 " + level.current_output);
}

function blockpuzzleinit(structarray) {
  flag_wait("strike_init_done");
  flag_wait("binary_puzzle_initialized");

  if(!isDefined(level.blocks)) {
    level.blocks = [];
  }

  var_af617b7501ac2ff5 = getEntArray("block_puzzle", "script_noteworthy");

  foreach(var_eea1264dd9d59093 in var_af617b7501ac2ff5) {
    var_eea1264dd9d59093.startpoint = var_eea1264dd9d59093.origin;
    var_6fc03e38f8cbf37d = getStruct(var_eea1264dd9d59093.target, "targetname");
    var_eea1264dd9d59093.endpoint = var_6fc03e38f8cbf37d.origin;
    var_29a13668ab4b5528 = strtok(var_eea1264dd9d59093.name, "_");
    blocknumber = int(var_29a13668ab4b5528[1]);
    var_eea1264dd9d59093.blocknumber = blocknumber;

    switch (var_eea1264dd9d59093.name) {
      case #"hash_6f85746e243f8969":
      case #"hash_6f85756e243f8afc":
      case #"hash_6f85766e243f8c8f":
      case #"hash_6f85776e243f8e22":
        level.blocks[blocknumber] = var_eea1264dd9d59093;
        orientblocksbasedonsequence(level.blocks_binary_sequence, var_eea1264dd9d59093, blocknumber);
        break;
    }
  }
}

function orientblocksbasedonsequence(blocks_binary_sequence, var_eea1264dd9d59093, blocknumber) {
  var_becbdfa822fd69e = strtok(blocks_binary_sequence, "_");
  one = int(var_becbdfa822fd69e[3]);
  two = int(var_becbdfa822fd69e[2]);
  four = int(var_becbdfa822fd69e[1]);
  eight = int(var_becbdfa822fd69e[0]);

  switch (blocknumber) {
    case 1:
      if(one == 1) {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.startpoint, 1, 0.2);
      } else {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.endpoint, 1, 0.2);
      }

      break;
    case 2:
      if(two == 1) {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.startpoint, 1, 0.2);
      } else {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.endpoint, 1, 0.2);
      }

      break;
    case 3:
      if(four == 1) {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.startpoint, 1, 0.2);
      } else {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.endpoint, 1, 0.2);
      }

      break;
    case 4:
      if(eight == 1) {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.startpoint, 1, 0.2);
      } else {
        var_eea1264dd9d59093 moveTo(var_eea1264dd9d59093.endpoint, 1, 0.2);
      }

      break;
  }
}

function blockpuzzlehint(interaction_struct, player) {
  if(istrue(level.playeraccessinglaptops)) {
    return &"CP_LAB/LOCKED";
  }

  return &"CP_LAB/BLOCK_SEQUENCE_TRIGGER";
}

function blockpuzzleactivation(interaction_struct, player) {
  decimal = convertfrombinary(level.current_blocks_sequence);

  if(decimal >= 15) {
    decimal = 0;
  } else {
    decimal++;
  }

  level.current_blocks_sequence = converttobinary(decimal, 1);
  level notify("input_sequence_changed");

  foreach(block in level.blocks) {
    orientblocksbasedonsequence(level.current_blocks_sequence, block, block.blocknumber);
  }
}

function caminit(var_7ebe92767a65429a) {
  precacheshader("nightvision_overlay_goggles_grain");
  cam_structs = getStructArray("cam_struct", "script_noteworthy");
  level.cam_target = getEnt("cam_target", "script_noteworthy");
  level.cam_target.targets = [];
  level.cam_target.finalstr = undefined;
  level.cameraactivationstructs = [];
  level.laptopinteractions = [];
  hack_structs = getStructArray("camhack_struct", "script_noteworthy");

  foreach(struct in var_7ebe92767a65429a) {
    foreach(str in cam_structs) {
      if(struct.script_label == str.name) {
        str.model = spawn("script_model", str.origin);
        str.model setModel("security_camera_small_white_01");
        str.bval = 0;

        if(isDefined(str.angles)) {
          str.model.angles = str.angles + (0, 0, 180);
        }

        str = rollsequencepercamera(str, hack_structs);
        level.cameraactivationstructs[level.cameraactivationstructs.size] = str;
        struct.camstr = str;
        struct.camstr.targetname = random(hack_structs);
        level.cam_target.targets[level.cam_target.targets.size] = struct.camstr.model;
        level.laptopinteractions[level.laptopinteractions.size] = struct;
      }
    }
  }

  level.hack_structs = [];
  temparr = hack_structs;

  foreach(var_8a15e145fbbcc32b in hack_structs) {
    var_8a15e145fbbcc32b.model = spawn("script_model", var_8a15e145fbbcc32b.origin);
    var_8a15e145fbbcc32b.model setModel("security_camera_small_white_01");

    if(isDefined(var_8a15e145fbbcc32b.angles)) {
      var_8a15e145fbbcc32b.model.angles = var_8a15e145fbbcc32b.angles + (0, 0, 180);
    }

    var_8a15e145fbbcc32b.sequencename = strtok(var_8a15e145fbbcc32b.name, "_")[1];
    level.hack_structs[level.hack_structs.size] = var_8a15e145fbbcc32b;
  }

  level thread rollnewcamerapath();
  level thread watchforcorrectsequencecompletion();
}

function watchforcorrectsequencecompletion() {
  while(true) {
    level waittill("sequence_changed", var_1430c2c17d46405f, var_1cdb7cbc2df1bcd1);

    if(!isDefined(level.balocked)) {
      level.balocked = 0;
    }

    if(!isDefined(level.bblocked)) {
      level.bblocked = 0;
    }

    if(!isDefined(level.bclocked)) {
      level.bclocked = 0;
    }

    if(!isDefined(level.bdlocked)) {
      level.bdlocked = 0;
    }

    foreach(var_1ba182408d3da4cb, sequence in level.finalsequence) {
      if(var_1430c2c17d46405f == sequence) {
        if(var_1ba182408d3da4cb == var_1cdb7cbc2df1bcd1) {
          switch (var_1ba182408d3da4cb) {
            case #"hash_b195b7771a2c2ac8":
              level.balocked = 1;
              break;
            case #"hash_b195ba771a2c2f81":
              level.bblocked = 1;
              break;
            case #"hash_b195b9771a2c2dee":
              level.bclocked = 1;
              break;
            case #"hash_b195bc771a2c32a7":
              level.bdlocked = 1;
              break;
          }
        }

        continue;
      }

      if(var_1ba182408d3da4cb == var_1cdb7cbc2df1bcd1) {
        switch (var_1ba182408d3da4cb) {
          case #"hash_b195b7771a2c2ac8":
            level.balocked = 0;
            break;
          case #"hash_b195ba771a2c2f81":
            level.bblocked = 0;
            break;
          case #"hash_b195b9771a2c2dee":
            level.bclocked = 0;
            break;
          case #"hash_b195bc771a2c32a7":
            level.bdlocked = 0;
            break;
        }
      }
    }

    if(level.balocked && level.bblocked && level.bclocked && level.bdlocked) {
      iprintlnbold(" THE SEQUENCES ARE CORRECT!! YOU CAN NOW ACCESS THE ELEVATOR! ");
      level.door_unlocked = 1;
      level.unlockedelevator = 1;
      level notify("unlock_pap_and_epic_weapon");
      level notify("end_target_door_watcher_thread");
      level notify("binary_puzzle_solved");
      break;
    }
  }
}

function rollsequencepercamera(camstr, var_28a1d8ee2f6cfc02) {
  size = var_28a1d8ee2f6cfc02.size;

  switch (camstr.name) {
    case #"hash_b195b7771a2c2ac8":
      camstr.sequencetype = "A_";
      break;
    case #"hash_b195ba771a2c2f81":
      camstr.sequencetype = "B_";
      break;
    case #"hash_b195b9771a2c2dee":
      camstr.sequencetype = "C_";
      break;
    case #"hash_b195bc771a2c32a7":
      camstr.sequencetype = "D_";
      break;
  }

  camstr.finalsequence = camstr.sequencetype;
  camstr.finalsequence += randomintrange(1, size + 1);

  println("<dev string:x1c>" + camstr.name + "<dev string:x3a>" + camstr.finalsequence);
  iprintlnbold("<dev string:x1c>" + camstr.name + "<dev string:x3a>" + camstr.finalsequence);

  if(!isDefined(level.finalsequence)) {
    level.finalsequence = [];
  }

  level.finalsequence[camstr.name] = camstr.finalsequence;
  return camstr;
}

function rollnewcamerapath() {
  level.chosenarray = scripts\engine\utility::array_randomize(level.hack_structs);
  level.cam_target.finalstr = level.chosenarray[level.hack_structs.size - 1];
  level.cam_target.finalstr.model hudoutlineenable("outlinefill_nodepth_red");
  level.mappedtargetsarray = settargetsbasedonchosenarray(level.chosenarray);
}

function settargetsbasedonchosenarray(chosenarray) {
  for(i = 0; i < chosenarray.size; i++) {
    if(isDefined(chosenarray[i + 1])) {
      chosenarray[i].target = chosenarray[i + 1];
    }
  }

  return chosenarray;
}

function generatepath(array) {
  assertex(isDefined(array), "check that the array is defined when passed in");
  start = 0;
  end = array.size - 1;
  assertex(isDefined(end), "check the target struct that's being passed in");
  permute(array, start, end);
}

function getindicesofelements(array, element) {
  foreach(var_a19bbe1fd4389e8d in array) {
    if(element == var_a19bbe1fd4389e8d) {
      return index;
    }
  }

  return undefined;
}

function swapviaarraylocations(arr, var_6c1a2b66e4d519f, var_6c1a3b66e4d53d2) {
  temp = arr[var_6c1a2b66e4d519f];
  arr[var_6c1a2b66e4d519f] = arr[var_6c1a3b66e4d53d2];
  arr[var_6c1a3b66e4d53d2] = temp;
  return arr;
}

function printpermute(arr, size) {
  for(i = 0; i <= size; i++) {
    waitframe();
  }

  level.escapepathpermutations[level.escapepathpermutations.size] = arr;
}

function permute(arr, start_idx, end_idx) {
  if(!isDefined(level.escapepathpermutations)) {
    level.escapepathpermutations = [];
  }

  if(start_idx == end_idx) {
    printpermute(arr, end_idx);
  }

  for(i = start_idx; i <= end_idx; i++) {
    arr = swapviaarraylocations(arr, start_idx, i);
    permute(arr, start_idx + 1, end_idx);
    arr = swapviaarraylocations(arr, start_idx, i);
  }
}

function is_player_looking_at_camera(start, angles, ignore_ent, var_e288d7904fbcf050) {
  if(within_fov(start, angles, var_e288d7904fbcf050.origin, cos(7.5))) {
    return 1;
  }

  return 0;
}

function is_player_looking_at(start, dot, dot_only, ignore_ent) {
  self endon("death");
  self endon("disconnect");
  self endon("leave_cam");

  if(!isDefined(dot)) {
    dot = 0.8;
  }

  player = self;
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  new_dot = vectordot(forward, player_forward);

  if(new_dot < dot) {
    return 0;
  }

  if(isDefined(dot_only)) {
    assertex(dot_only, "dot_only must be true or undefined");
    return 1;
  }

  return ray_trace_detail_passed(start, end, ignore_ent, create_default_contents(1));
}

function check_looking_at(fdelay) {
  self notify("one_instance_for_" + self.model);
  self endon("one_instance_for_" + self.model);
  level endon("end_target_door_watcher_thread");

  if(isDefined(fdelay)) {
    wait fdelay;
  } else {
    waitframe();
  }

  level.cam_target.finalstr.model hudoutlineenable("outlinefill_nodepth_red");

  while(true) {
    foreach(player in level.players) {
      if(player worldpointinreticle_circle(self.origin, 10, 10000)) {
        if(istrue(player.isusingcamera)) {
          if(isDefined(player.currentcamera)) {
            if(level.cam_target.finalstr == player.currentcamera) {
              level.cam_target.finalstr.model hudoutlineenable("outlinefill_nodepth_cyan");
              level.door_unlocked = 1;
              level notify("unlock_pap_and_epic_weapon");
              level notify("end_target_door_watcher_thread");
            }
          }
        }
      }
    }

    waitframe();
  }
}

function init_camera_interaction() {
  scripts\cp\interaction::register_interaction("cam_interaction", "null", undefined, &camhint, &camactivation, 0, 0, &caminit);
}

function camhint(interaction_struct, player) {
  if(istrue(level.door_unlocked)) {
    return "";
  }

  if(interaction_struct.camstr.bval != 1) {
    return &"CP_LAB/LOCKED";
  }

  if(isDefined(interaction_struct.hacker)) {
    return &"CP_LAB/LOCKED";
  }

  if(!istrue(level.sequence_locked)) {
    return &"CP_LAB/LOCKED";
  }

  return &"CP_LAB/ENTER_CAMERAS";
}

function camactivation(interaction_struct, player) {
  player endon("disconnect");

  if(interaction_struct.camstr.bval != 1) {
    return;
  }

  if(!istrue(level.sequence_locked)) {
    return;
  }

  if(istrue(level.door_unlocked)) {
    player iprintln(" ^7YOU'VE ALREADY FINISHED THIS PUZZLE");
    return;
  }

  if(isDefined(interaction_struct.hacker)) {
    player iprintln("^7" + interaction_struct.hacker + " ^3 IS ALREADY ACCESSING THE CAMERAS...Try again later");
    return;
  }

  if(!isDefined(interaction_struct.camstr.angles)) {
    interaction_struct.camstr.angles = (0, 0, 0);
  }

  player.enteredcamera = 1;
  outline_fade_alpha_for_index(6, 0, 0);
  player notify("enter_cam");
  interaction_struct.hacker = player;
  level.playeraccessinglaptops = 1;
  player.og_origin = player.origin;
  player.og_angles = player getplayerangles();
  player.og_stance = player getstance();
  fwd = anglesToForward(interaction_struct.camstr.angles);
  to_camera = vectorNormalize(interaction_struct.camstr.origin - player getorigin());
  dot = vectordot(fwd, to_camera);
  tag = spawn("script_model", player.origin);
  tag setModel("tag_player");
  tag.origin = interaction_struct.camstr.origin;
  tag.angles = interaction_struct.camstr.angles;
  put_player_on_cam(tag, player, interaction_struct);
  level.cam_hud = snake_door_cam_hud(player);

  while(player useButtonPressed()) {
    if(!istrue(player.enteredcamera)) {
      break;
    }

    wait 0.05;
  }

  waittill_player_exits_cam(player);
  nudge_spot = tag.origin + anglesToForward(tag.angles) * -20;
  player.enteredcamera = undefined;

  if(!istrue(player.enteredcamera)) {
    tag moveTo(nudge_spot, 0.05);
  } else {
    tag moveTo(nudge_spot, 0.5, 0.125);
  }

  wait 0.25;
  player notify("leave_cam");

  foreach(thing in level.cam_hud) {
    thing destroy();
  }

  level thread static_burst(0.125, player);
  level add_wait(&waittill_msg, "static_faded_in");
  do_wait_any();
  outline_fade_alpha_for_index(6, 0.8, 0);
  level notify("vision_set_change_request", undefined, player, 0.5, "snake_cam");
  setsaveddvar(@ "hash_83bbe73116f488d6", 0);
  setsaveddvar(@ "hash_ed28298c207316ae", 0);
  setsaveddvar(@ "hash_979b5474be3b9b47", 0);
  setsaveddvar(@ "hash_960ef00238357bbc", 0);
  wait 0.1;
  remove_player_from_cam(player);
  interaction_struct.hacker = undefined;
  level.playeraccessinglaptops = undefined;
  outline_fade_alpha_for_index(6, 0, 6);
}

function remove_door_snake_cam_ability() {
  foreach(struct in self.cam_structs) {
    if(isDefined(struct)) {
      struct notify("stop_snake_cam");
      struct remove_cursor_hint();
    }
  }
}

function unlock_pap_and_ww() {
  level waittill("unlock_pap_and_epic_weapon");
  level notify("delete_sequence_timer_thread");
  iprintln(" ^7YOU HAVE UNLOCKED AN EPIC WEAPON AND PACK - A -PUNCH ");
  level.pap_unlocked = 1;
  structarray = getStructArray("weapon_pickup", "script_noteworthy");

  foreach(struct in structarray) {
    if(isDefined(struct.script_parameters)) {
      name = scripts\cp\weapon::getcompletenameforweapon(struct.script_parameters + "_mp");
      println("<dev string:x43>" + name);
      weapon = spawn("weapon_" + name, struct.origin);
      weapon itemweaponsetammo(weaponclipsize(name), weaponmaxammo(name));
    }
  }
}

function snake_cam_control(player) {
  player endon("leave_cam");
  og_angles = self.angles;
  minpitch = -90;
  maxpitch = 90;
  yawdeltamax = 90;
  var_aae6a37f78b5674 = 90;
  minyaw = og_angles[1] - yawdeltamax;
  maxyaw = og_angles[1] + yawdeltamax;
  minroll = og_angles[2] - var_aae6a37f78b5674;
  maxroll = og_angles[2] + var_aae6a37f78b5674;
  ddeadzone = 20;
  dmaxroll = 90;
  var_440ebeeb83bd05a8 = 0.6;
  var_75eb1524afeb7f2b = 0.8;
  dmaxangle = 10;
  dyaw = 4;
  dpitch = 1.2;
  var_d296b0eaf4a6b00f = [0, 0];
  var_d5e6310914396ac3 = 0.2;
  var_848e35f763ce65b0 = 0.2;
  rumble_playing = 0;

  while(true) {
    currentangles = self.angles;
    currentcamangles = player.cam_ent.angles;
    input = player getnormalizedmovement();
    input = [-1, 1];
    multiplier = 0;
    normalinput = (input[0], input[1], 0);
    normalinput = length(normalinput);
    inputlerprate = math::factor_value(var_848e35f763ce65b0, var_d5e6310914396ac3, normalinput);
    var_d296b0eaf4a6b00f[0] = math::lerp(var_d296b0eaf4a6b00f[0], input[0], inputlerprate);
    var_d296b0eaf4a6b00f[1] = math::lerp(var_d296b0eaf4a6b00f[1], input[1], inputlerprate);

    if(currentangles[0] > 0 && var_d296b0eaf4a6b00f[0] < 0) {
      var_13a3fd6ddfa8548f = 1 - math::normalize_value(maxpitch * var_440ebeeb83bd05a8, maxpitch, currentangles[0]);
    } else if(currentangles[0] < 0 && var_d296b0eaf4a6b00f[0] > 0) {
      var_13a3fd6ddfa8548f = math::normalize_value(minpitch, minpitch * var_440ebeeb83bd05a8, currentangles[0]);
    } else {
      var_13a3fd6ddfa8548f = 1;
    }

    if(currentangles[1] > og_angles[1] && var_d296b0eaf4a6b00f[1] < 0) {
      var_8366082d034c6132 = 1 - math::normalize_value(maxyaw - yawdeltamax * var_75eb1524afeb7f2b, maxyaw, currentangles[1]);
    } else if(currentangles[1] < og_angles[1] && var_d296b0eaf4a6b00f[1] > 0) {
      var_8366082d034c6132 = math::normalize_value(minyaw, minyaw + yawdeltamax * var_75eb1524afeb7f2b, currentangles[1]);
    } else {
      var_8366082d034c6132 = 1;
    }

    inputyaw = var_d296b0eaf4a6b00f[1] * -1;
    nextyaw = currentangles[1] + dyaw * inputyaw * var_8366082d034c6132;

    if(nextyaw > og_angles[1]) {
      multiplier = math::normalized_float_smooth_out(math::normalize_value(og_angles[1], maxyaw, nextyaw)) * -1;
    }

    if(nextyaw < og_angles[1]) {
      multiplier = 1 - math::normalized_float_smooth_in(math::normalize_value(minyaw, og_angles[1], nextyaw));
    }

    inputroll = input[1];
    nextroll = og_angles[2] + dmaxroll * multiplier;
    maxroll *= multiplier;
    nextyaw = clamp(nextyaw, minyaw, maxyaw);
    inputpitch = var_d296b0eaf4a6b00f[0] * -1;
    nextpitch = currentangles[0] + dpitch * inputpitch * var_13a3fd6ddfa8548f;
    minpitchclamp = minpitch;
    maxpitchclamp = maxpitch;
    nextpitch = clamp(nextpitch, minpitchclamp, maxpitchclamp);
    snakeangles = (nextpitch, nextyaw, nextroll);
    movementfactor = length(snakeangles - self.angles);
    movementfactor = math::normalize_value(0, 1.5, movementfactor);
    quake = math::factor_value(0, 0.105, movementfactor);
    rumble = math::factor_value(0, 0.08, movementfactor);
    volume = math::factor_value(0, 0.2, movementfactor);

    if(quake > 0.005) {
      earthquake(quake, 0.07, player.origin, 2000);
    }

    if(rumble > 0.0001) {
      if(!rumble_playing) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        rumble_playing = 1;
      }
    } else if(rumble_playing) {
      self.rumbleent stoprumble("steady_rumble");
      rumble_playing = 0;
    }

    height = 1 - rumble;
    height *= 1000;
    self.rumbleent.origin = player getEye() + (0, 0, height);
    self.angles = snakeangles;
    nudge_spot = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    player.cam_ent.origin = nudge_spot;
    player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

function put_player_on_cam(tag, player, interaction_struct) {
  nudge_spot = tag.origin + anglesToForward(tag.angles) * 12 - (0, 0, 55);
  player.cam_ent = tag;
  player.isusingcamera = 1;
  player.currentcamera = interaction_struct.camstr;
  player.cameratarget = interaction_struct.camstr.targetname;
  player val::set("player_on_cam", "fire", 0);
  player cameraunlink();
  player cameralinkTo(player.cam_ent, "tag_player", 1);
  player playerlinkweaponviewtodelta(player.cam_ent, "tag_player", 1);
  player playerlinkedsetviewznear(0);
  player setplayerangles(tag.angles);
  thread watchforcameralookatothercameras(player, interaction_struct);
}

function watchforcameralookatothercameras(player, interaction_struct) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  foreach(camerastruct in level.hack_structs) {
    camerastruct.model thread watchforplayerlookat(player, camerastruct);
    camerastruct.model thread watchforcameralaunch(player, camerastruct, interaction_struct);
  }
}

function watchforcameralaunch(player, camerastruct, interaction_struct) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");
  player notifyonplayercommand("enter_hack_cam", "+attack");

  while(true) {
    player waittill("enter_hack_cam");

    if(istrue(self.outlined)) {
      player thread enter_hacked_cam_model(self, camerastruct, interaction_struct);
    }
  }
}

function watchforplayerlookat(player, camerastruct) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  while(true) {
    wait 0.07;

    if(player is_player_looking_at_camera(player.cam_ent.origin, player getplayerangles(), player, self)) {
      self hudoutlineenableforclient(player, "outlinefill_nodepth_cyan");
      self.outlined = 1;
      continue;
    }

    self hudoutlinedisableforclient(player);
    self.outlined = undefined;
  }
}

function watchforcurrentcamerahack(player, currentcamera, cameratarget) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");
  cameraent = player.cam_ent;

  if(!isDefined(cameratarget)) {
    return;
  }

  cameratarget.model thread watchforlookathackcam(player, cameratarget, cameraent);
  cameratarget thread watchforplayerfirepress(player);
}

function watchforplayerfirepress(player) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");
  player notifyonplayercommand("enter_hack_cam", "+attack");

  while(true) {
    player waittill("enter_hack_cam");

    if(istrue(self.model.outlined)) {
      player thread enter_hacked_cam(self);
      continue;
    }

    player iprintln("^1 YOU TRIED TO ENTER THE WRONG CAMERA! FAIL!");
    level.cam_target.finalstr.model hudoutlinedisable();
    level notify("override_cooldowns");
    flag_set("exit_snakecam_immediately");
  }
}

function enter_hacked_cam_model(var_609f3dae81876c41, camerastruct, interaction_struct) {
  var_609f3dae81876c41 hudoutlineenableforclient(self, "outlinefill_nodepth_orange");
  self notify("switch_cams");
  outline_fade_alpha_for_index(6, 0, 0);
  level thread static_burst(0.1, self);
  self.cam_ent.origin = var_609f3dae81876c41.origin;
  self.cam_ent.angles = self.angles;
  self.currentcamera = var_609f3dae81876c41;
  var_1430c2c17d46405f = interaction_struct.camstr.sequencetype + camerastruct.sequencename;

  if(var_1430c2c17d46405f == interaction_struct.camstr.finalsequence) {
    self iprintln("^4this is the correct Sequence for ^7" + interaction_struct.camstr.name);
  }

  level notify("sequence_changed", var_1430c2c17d46405f, interaction_struct.camstr.name);
  thread watchforcameralookatothercameras(self, interaction_struct);
}

function enter_hacked_cam(var_2c70181123b48543) {
  var_2c70181123b48543.model hudoutlineenableforclient(self, "outlinefill_nodepth_orange");
  self notify("switch_cams");
  outline_fade_alpha_for_index(6, 0, 0);
  level thread static_burst(0.1, self);
  self.cam_ent.origin = var_2c70181123b48543.origin;
  self.cam_ent.angles = var_2c70181123b48543.angles;
  self.cameratarget = var_2c70181123b48543.target;
  self.currentcamera = var_2c70181123b48543;
  thread watchforcurrentcamerahack(self, self.currentcamera, self.cameratarget);
}

function watchforlookathackcam(player, var_2c70181123b48543, cameraent) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  while(true) {
    wait 0.1;

    if(player worldpointinreticle_circle(self.origin, 10, 2000)) {
      if(istrue(self.outlined)) {
        self hudoutlineenableforclient(player, "outlinefill_nodepth_cyan");
        continue;
      }

      if(isDefined(player.cameratarget) && isDefined(var_2c70181123b48543.name)) {
        if(player.cameratarget.name == var_2c70181123b48543.name) {
          self hudoutlineenableforclient(player, "outlinefill_nodepth_green");
          self.outlined = 1;
        }
      } else if(level.cam_target.finalstr.model != self) {
        self hudoutlinedisableforclient(player);
        self.outlined = undefined;
      }

      continue;
    }

    if(level.cam_target.finalstr.model != self) {
      self hudoutlinedisableforclient(player);
      self.outlined = undefined;
    }
  }
}

function remove_player_from_cam(player) {
  player unlink();
  player cameraunlink();
  player controlsunlink();
  player setOrigin(player.og_origin);
  player setplayerangles(player.og_angles);
  player setstance(player.og_stance);
  player val::reset_all("player_on_cam");
  player.isusingcamera = 0;
  player.cameraused = undefined;
  player.cameratarget = undefined;

  foreach(var_2c70181123b48543 in level.hack_structs) {
    if(istrue(var_2c70181123b48543.model.outlined)) {
      var_2c70181123b48543.model hudoutlinedisableforclient(player);
      var_2c70181123b48543.model.outlined = undefined;
    }
  }
}

function waittill_player_exits_cam(player) {
  while(true) {
    if(player_is_trying_to_exit_camera(player)) {
      break;
    }

    if(!istrue(player.enteredcamera)) {
      break;
    }

    if(!istrue(level.sequence_locked)) {
      break;
    }

    if(istrue(level.unlockedelevator)) {
      break;
    }

    if(istrue(self.disabled)) {
      break;
    }

    waitframe();
  }
}

function player_is_trying_to_exit_camera(player) {
  return player useButtonPressed() || player fragButtonPressed() || player meleeButtonPressed() || player buttonPressed("BUTTON_B") || player jumpbuttonPressed() || player buttonPressed("BUTTON_LSTICK") || player buttonPressed("BUTTON_RSTICK");
}

function static_burst(duration, player) {
  fade_time = 0.25;
  duration = ter_op(isDefined(duration), duration, 0.5);
  static = create_client_overlay("white", 1, player);
  static.alpha = 0;
  static fadeovertime(fade_time);
  static.alpha = 1;
  wait fade_time;
  level notify("static_faded_in");
  wait duration;
  static fadeovertime(fade_time);
  static.alpha = 0;
  wait fade_time;
  level notify("static_faded_out");
  static destroy();
}

function snake_door_cam_hud(player) {
  crosshair = newhudelem();
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 0.7;
  crosshair.y = 233;
  crosshair settext(&"CP_LAB/CAMERA_CROSSHAIR");
  overlay = newhudelem();
  overlay.x = 292;
  overlay.y = 60;
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.font = "smallfixed";
  overlay.fontscale = 0.75;
  overlay settext(&"CP_LAB/CAMERA_CONTROLS");
  goggles = create_client_overlay("nightvision_overlay_goggles_grain", 1, player);
  level notify("vision_set_change_request", "snake_cam", player);
  setsaveddvar(@ "hash_83bbe73116f488d6", 0.5);
  setsaveddvar(@ "hash_ed28298c207316ae", 0.2);
  setsaveddvar(@ "hash_979b5474be3b9b47", -0.75);
  setsaveddvar(@ "hash_960ef00238357bbc", 0.011);
  return [crosshair, goggles, overlay];
}

function fake_effects(start, end, model, player) {
  while(true) {
    start = model.origin;
    end = model.origin + anglesToForward(player.angles) * 1000;
    wait 1;
  }
}

function draw_line_for_time_endon_death(org1, org2, r, g, b, timer) {
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1);
    wait 0.05;
  }
}

function draw_angles_on_line(start, end, r, g, b, timer, model) {
  model endon("death");
  var_4dffbf84669f6c5 = spawn("script_model", start);
  var_4dffbf84669f6c5 moveTo(end, 1);

  for(i = 0; i < timer; i++) {
    thread draw_capsule(var_4dffbf84669f6c5.origin, 3, 3, model.angles, (1, 0, 0), 0, 1);
    wait 0.05;
  }

  var_4dffbf84669f6c5 delete();
}