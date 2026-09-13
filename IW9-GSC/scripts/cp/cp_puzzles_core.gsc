/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_puzzles_core.gsc
***********************************************/

init() {
  level thread _id_489BC5FF08558A82::init();
}

init_binary_puzzle() {
  reroll_binary_op();
  scripts\engine\utility::flag_set("binary_puzzle_initialized");
  level thread updatecurrentoutput();
}

reroll_binary_op() {
  level.escape_binary_sequence = calculatecorrectbinarysequence();
  level.current_cbreaker_sequence = "0_0_0_0";
  level.blocks_binary_sequence = calculatefourbitbinarysequence();
  level.current_blocks_sequence = level.blocks_binary_sequence;
  level.sequence_operator = determineoperation();
  iprintln(" ^1 BINARY SEQUENCES AND OPERATIONS CHANGED!!! LOOK AGAIN!! ");
}

updatecurrentoutput() {
  _id_CE4C3B78F5A285DE = getdvarint("dvar_D889F30225B83FA5", 0);

  if(_id_CE4C3B78F5A285DE != 0)
    level.current_output = _id_CE4C3B78F5A285DE;
  else
    level.current_output = performoperation(level.current_cbreaker_sequence, level.current_blocks_sequence, level.sequence_operator);

  for(;;) {
    level waittill("input_sequence_changed");
    _id_CE4C3B78F5A285DE = getdvarint("dvar_D889F30225B83FA5", 0);

    if(_id_CE4C3B78F5A285DE != 0)
      level.current_output = _id_CE4C3B78F5A285DE;
    else
      level.current_output = performoperation(level.current_cbreaker_sequence, level.current_blocks_sequence, level.sequence_operator);

    _id_4250E8F4232A71C5 = converttobinary(level.current_output, 1);
    iprintln(" ^1 BINARY VALUES FOR THE LAPTOPS - ^7" + _id_4250E8F4232A71C5);
    _id_1C3321F0F58F0E6C = strtok(_id_4250E8F4232A71C5, "_");

    foreach(struct in level.cameraactivationstructs) {
      switch (struct.name) {
        case "cam_1":
          struct.bval = int(_id_1C3321F0F58F0E6C[0]);
          break;
        case "cam_2":
          struct.bval = int(_id_1C3321F0F58F0E6C[1]);
          break;
        case "cam_3":
          struct.bval = int(_id_1C3321F0F58F0E6C[2]);
          break;
        case "cam_4":
          struct.bval = int(_id_1C3321F0F58F0E6C[3]);
          break;
      }
    }
  }
}

determineoperation() {
  array = ["add", "sub", "and", "or", "xor"];
  _id_DC061F521C45D732 = scripts\engine\utility::random(array);
  return _id_DC061F521C45D732;
}

performoperation(_id_23593744EB26DB24, _id_23593A44EB26E1BD, operator) {
  _id_F69E39E78FA16603 = 666;

  switch (operator) {
    case "and":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) &convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "or":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) | convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "xor":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) ^ convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "add":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) + convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 >= 15)
        _id_F69E39E78FA16603 = 15;

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "sub":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) - convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "sr":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) >> convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
    case "sl":
      _id_F69E39E78FA16603 = convertfrombinary(_id_23593744EB26DB24) << convertfrombinary(_id_23593A44EB26E1BD);

      if(_id_F69E39E78FA16603 <= 0)
        _id_F69E39E78FA16603 = 0;

      return _id_F69E39E78FA16603;
  }
}

calculatefourbitbinarysequence() {
  _id_F4CAE9D2914CC11B = randomintrange(1, 16);
  return converttobinary(_id_F4CAE9D2914CC11B, 1);
}

calculatecorrectbinarysequence() {
  _id_F4CAE9D2914CC11B = randomintrange(1, 16);
  return converttobinary(_id_F4CAE9D2914CC11B, 1);
}

converttobinary(_id_A166868464F52912, _id_130C7170B6A041D4) {
  switch (_id_A166868464F52912) {
    case 0:
      if(istrue(_id_130C7170B6A041D4))
        return "0_0_0_0";

      return "0_0_0";
    case 1:
      if(istrue(_id_130C7170B6A041D4))
        return "0_0_0_1";

      return "0_0_1";
    case 2:
      if(istrue(_id_130C7170B6A041D4))
        return "0_0_1_0";

      return "0_1_0";
    case 3:
      if(istrue(_id_130C7170B6A041D4))
        return "0_0_1_1";

      return "0_1_1";
    case 4:
      if(istrue(_id_130C7170B6A041D4))
        return "0_1_0_0";

      return "1_0_0";
    case 5:
      if(istrue(_id_130C7170B6A041D4))
        return "0_1_0_1";

      return "1_0_1";
    case 6:
      if(istrue(_id_130C7170B6A041D4))
        return "0_1_1_0";

      return "1_1_0";
    case 7:
      if(istrue(_id_130C7170B6A041D4))
        return "0_1_1_1";

      return "1_1_1";
    case 8:
      if(istrue(_id_130C7170B6A041D4))
        return "1_0_0_0";
    case 9:
      if(istrue(_id_130C7170B6A041D4))
        return "1_0_0_1";
    case 10:
      if(istrue(_id_130C7170B6A041D4))
        return "1_0_1_0";
    case 11:
      if(istrue(_id_130C7170B6A041D4))
        return "1_0_1_1";
    case 12:
      if(istrue(_id_130C7170B6A041D4))
        return "1_1_0_0";
    case 13:
      if(istrue(_id_130C7170B6A041D4))
        return "1_1_0_1";
    case 14:
      if(istrue(_id_130C7170B6A041D4))
        return "1_1_1_0";
    case 15:
      if(istrue(_id_130C7170B6A041D4))
        return "1_1_1_1";

      break;
    default:
      iprintln(" you should not be getting this result. Error in Script - Aj ");
      break;
  }
}

convertfrombinary(_id_8AFFA1D52E6AA880) {
  _id_0BECBDFA822FD69E = strtok(_id_8AFFA1D52E6AA880, "_");
  _id_54588204349C77DB = int(_id_0BECBDFA822FD69E[3]);
  _id_E94F7B032A5F1695 = int(_id_0BECBDFA822FD69E[2]);
  _id_47E5B099C2CCBA89 = int(_id_0BECBDFA822FD69E[1]);
  _id_3D242293F7E9ABCC = int(_id_0BECBDFA822FD69E[0]);
  _id_E3C151091A692F60 = _id_54588204349C77DB * 1 + _id_E94F7B032A5F1695 * 2 + _id_47E5B099C2CCBA89 * 4 + _id_3D242293F7E9ABCC * 8;
  return _id_E3C151091A692F60;
}

getbinarysequencemapping() {
  array = ["f", "f_r", "r", "b_r", "b", "b_l", "l", "f_l"];
  _id_69D32D6403BEF4E0 = scripts\engine\utility::random(array);
  _id_E0CF7ACECAB4470F = [];
  chosen = 0;
  counter = 0;
  _id_2FE0C25B7C39977C = array;

  foreach(index, _id_F7806D4CF24AACD3 in array)
  _id_E0CF7ACECAB4470F[_id_F7806D4CF24AACD3] = converttobinary(index);

  return _id_E0CF7ACECAB4470F;
}

calculaterangeofprojectilemotion(_id_AC0E454AC96A77AC, _id_450483A591A06439) {
  _id_26D9CE38D34A1302 = squared(_id_AC0E454AC96A77AC) * sin(2 * _id_450483A591A06439) / 19.62;
}

init_block_puzzle_interaction() {
  _id_71332A5B74214116::register_interaction("block_puzzle_interaction", "null", undefined, ::blockpuzzlehint, ::blockpuzzleactivation, 0, 0, ::blockpuzzleinit);
  _id_71332A5B74214116::register_interaction("view_operation_result", "null", undefined, ::viewoperationhint, ::viewoperationactivation, 0, 0, ::viewoperationinit);
}

viewoperationinit(_id_70DAB3207FB65169) {
  foreach(str in _id_70DAB3207FB65169) {
    str.model = spawn("script_model", str.origin);
    str.model setModel("button_on_green");

    if(isDefined(str.angles))
      str.model.angles = str.angles;
  }
}

viewoperationhint(_id_DF071553D0996FF9, player) {
  return &"CP_LAB/VIEW_OP_RESULT";
}

viewoperationactivation(_id_DF071553D0996FF9, player) {
  player iprintln("^5 CURRENT RESULT WITH THE ^1 " + level.sequence_operator + "^5 OPERATOR IS- ^8 " + level.current_output);
}

blockpuzzleinit(_id_70DAB3207FB65169) {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("binary_puzzle_initialized");

  if(!isDefined(level.blocks))
    level.blocks = [];

  _id_AF617B7501AC2FF5 = getEntArray("block_puzzle", "script_noteworthy");

  foreach(index, _id_EEA1264DD9D59093 in _id_AF617B7501AC2FF5) {
    _id_EEA1264DD9D59093.startpoint = _id_EEA1264DD9D59093.origin;
    _id_6FC03E38F8CBF37D = scripts\engine\utility::getStruct(_id_EEA1264DD9D59093.target, "targetname");
    _id_EEA1264DD9D59093.endpoint = _id_6FC03E38F8CBF37D.origin;
    _id_29A13668AB4B5528 = strtok(_id_EEA1264DD9D59093.name, "_");
    blocknumber = int(_id_29A13668AB4B5528[1]);
    _id_EEA1264DD9D59093.blocknumber = blocknumber;

    switch (_id_EEA1264DD9D59093.name) {
      case "block_4":
      case "block_3":
      case "block_2":
      case "block_1":
        level.blocks[blocknumber] = _id_EEA1264DD9D59093;
        orientblocksbasedonsequence(level.blocks_binary_sequence, _id_EEA1264DD9D59093, blocknumber);
        break;
    }
  }
}

orientblocksbasedonsequence(blocks_binary_sequence, _id_EEA1264DD9D59093, blocknumber) {
  _id_0BECBDFA822FD69E = strtok(blocks_binary_sequence, "_");
  _id_54588204349C77DB = int(_id_0BECBDFA822FD69E[3]);
  _id_E94F7B032A5F1695 = int(_id_0BECBDFA822FD69E[2]);
  _id_47E5B099C2CCBA89 = int(_id_0BECBDFA822FD69E[1]);
  _id_3D242293F7E9ABCC = int(_id_0BECBDFA822FD69E[0]);

  switch (blocknumber) {
    case 1:
      if(_id_54588204349C77DB == 1)
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.startpoint, 1, 0.2);
      else
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.endpoint, 1, 0.2);

      break;
    case 2:
      if(_id_E94F7B032A5F1695 == 1)
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.startpoint, 1, 0.2);
      else
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.endpoint, 1, 0.2);

      break;
    case 3:
      if(_id_47E5B099C2CCBA89 == 1)
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.startpoint, 1, 0.2);
      else
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.endpoint, 1, 0.2);

      break;
    case 4:
      if(_id_3D242293F7E9ABCC == 1)
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.startpoint, 1, 0.2);
      else
        _id_EEA1264DD9D59093 moveTo(_id_EEA1264DD9D59093.endpoint, 1, 0.2);

      break;
  }
}

blockpuzzlehint(_id_DF071553D0996FF9, player) {
  if(istrue(level.playeraccessinglaptops))
    return &"CP_LAB/LOCKED";

  return &"CP_LAB/BLOCK_SEQUENCE_TRIGGER";
}

blockpuzzleactivation(_id_DF071553D0996FF9, player) {
  _id_A3EDD56137BB2540 = convertfrombinary(level.current_blocks_sequence);

  if(_id_A3EDD56137BB2540 >= 15)
    _id_A3EDD56137BB2540 = 0;
  else
    _id_A3EDD56137BB2540++;

  level.current_blocks_sequence = converttobinary(_id_A3EDD56137BB2540, 1);
  level notify("input_sequence_changed");

  foreach(_id_938F333E5DC17DC6 in level.blocks)
  orientblocksbasedonsequence(level.current_blocks_sequence, _id_938F333E5DC17DC6, _id_938F333E5DC17DC6.blocknumber);
}

caminit(_id_7EBE92767A65429A) {
  precacheshader("nightvision_overlay_goggles_grain");
  cam_structs = scripts\engine\utility::getStructArray("cam_struct", "script_noteworthy");
  level.cam_target = getEnt("cam_target", "script_noteworthy");
  level.cam_target.targets = [];
  level.cam_target.finalstr = undefined;
  level.cameraactivationstructs = [];
  level.laptopinteractions = [];
  hack_structs = scripts\engine\utility::getStructArray("camhack_struct", "script_noteworthy");

  foreach(struct in _id_7EBE92767A65429A) {
    foreach(str in cam_structs) {
      if(struct.script_label == str.name) {
        str.model = spawn("script_model", str.origin);
        str.model setModel("security_camera_small_white_01");
        str.bval = 0;

        if(isDefined(str.angles))
          str.model.angles = str.angles + (0, 0, 180);

        str = rollsequencepercamera(str, hack_structs);
        level.cameraactivationstructs[level.cameraactivationstructs.size] = str;
        struct.camstr = str;
        struct.camstr.targetname = scripts\engine\utility::random(hack_structs);
        level.cam_target.targets[level.cam_target.targets.size] = struct.camstr.model;
        level.laptopinteractions[level.laptopinteractions.size] = struct;
      }
    }
  }

  level.hack_structs = [];
  _id_5C397C9CF7A06802 = hack_structs;

  foreach(_id_8A15E145FBBCC32B in hack_structs) {
    _id_8A15E145FBBCC32B.model = spawn("script_model", _id_8A15E145FBBCC32B.origin);
    _id_8A15E145FBBCC32B.model setModel("security_camera_small_white_01");

    if(isDefined(_id_8A15E145FBBCC32B.angles))
      _id_8A15E145FBBCC32B.model.angles = _id_8A15E145FBBCC32B.angles + (0, 0, 180);

    _id_8A15E145FBBCC32B.sequencename = strtok(_id_8A15E145FBBCC32B.name, "_")[1];
    level.hack_structs[level.hack_structs.size] = _id_8A15E145FBBCC32B;
  }

  level thread rollnewcamerapath();
  level thread watchforcorrectsequencecompletion();
}

watchforcorrectsequencecompletion() {
  for(;;) {
    level waittill("sequence_changed", _id_1430C2C17D46405F, _id_1CDB7CBC2DF1BCD1);

    if(!isDefined(level.balocked))
      level.balocked = 0;

    if(!isDefined(level.bblocked))
      level.bblocked = 0;

    if(!isDefined(level.bclocked))
      level.bclocked = 0;

    if(!isDefined(level.bdlocked))
      level.bdlocked = 0;

    foreach(_id_1BA182408D3DA4CB, _id_927B3199642B75FC in level.finalsequence) {
      if(_id_1430C2C17D46405F == _id_927B3199642B75FC) {
        if(_id_1BA182408D3DA4CB == _id_1CDB7CBC2DF1BCD1) {
          switch (_id_1BA182408D3DA4CB) {
            case "cam_1":
              level.balocked = 1;
              break;
            case "cam_2":
              level.bblocked = 1;
              break;
            case "cam_3":
              level.bclocked = 1;
              break;
            case "cam_4":
              level.bdlocked = 1;
              break;
          }
        }

        continue;
      }

      if(_id_1BA182408D3DA4CB == _id_1CDB7CBC2DF1BCD1) {
        switch (_id_1BA182408D3DA4CB) {
          case "cam_1":
            level.balocked = 0;
            break;
          case "cam_2":
            level.bblocked = 0;
            break;
          case "cam_3":
            level.bclocked = 0;
            break;
          case "cam_4":
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

rollsequencepercamera(camstr, _id_28A1D8EE2F6CFC02) {
  _id_A61C75B156FC1EE0 = _id_28A1D8EE2F6CFC02.size;

  switch (camstr.name) {
    case "cam_1":
      camstr.sequencetype = "A_";
      break;
    case "cam_2":
      camstr.sequencetype = "B_";
      break;
    case "cam_3":
      camstr.sequencetype = "C_";
      break;
    case "cam_4":
      camstr.sequencetype = "D_";
      break;
  }

  camstr.finalsequence = camstr.sequencetype;
  camstr.finalsequence = camstr.finalsequence + randomintrange(1, _id_A61C75B156FC1EE0 + 1);
  iprintlnbold(" ^2 THE FINAL SEQUENCE FOR ^3" + camstr.name + "^2 IS ^6" + camstr.finalsequence);

  if(!isDefined(level.finalsequence))
    level.finalsequence = [];

  level.finalsequence[camstr.name] = camstr.finalsequence;
  return camstr;
}

rollnewcamerapath() {
  level.chosenarray = scripts\engine\utility::array_randomize(level.hack_structs);
  level.cam_target.finalstr = level.chosenarray[level.hack_structs.size - 1];
  level.cam_target.finalstr.model hudoutlineenable("outlinefill_nodepth_red");
  level.mappedtargetsarray = settargetsbasedonchosenarray(level.chosenarray);
}

settargetsbasedonchosenarray(chosenarray) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < chosenarray.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(chosenarray[_id_AC0E594AC96AA3A8 + 1]))
      chosenarray[_id_AC0E594AC96AA3A8].target = chosenarray[_id_AC0E594AC96AA3A8 + 1];
  }

  return chosenarray;
}

generatepath(array) {
  start = 0;
  end = array.size - 1;
  permute(array, start, end);
}

getindicesofelements(array, _id_F7806D4CF24AACD3) {
  foreach(index, _id_A19BBE1FD4389E8D in array) {
    if(_id_F7806D4CF24AACD3 == _id_A19BBE1FD4389E8D)
      return index;
  }

  return undefined;
}

swapviaarraylocations(_id_8B462903A1F84F9C, _id_06C1A2B66E4D519F, _id_06C1A3B66E4D53D2) {
  temp = _id_8B462903A1F84F9C[_id_06C1A2B66E4D519F];
  _id_8B462903A1F84F9C[_id_06C1A2B66E4D519F] = _id_8B462903A1F84F9C[_id_06C1A3B66E4D53D2];
  _id_8B462903A1F84F9C[_id_06C1A3B66E4D53D2] = temp;
  return _id_8B462903A1F84F9C;
}

printpermute(_id_8B462903A1F84F9C, _id_A61C75B156FC1EE0) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++)
    waitframe();

  level.escapepathpermutations[level.escapepathpermutations.size] = _id_8B462903A1F84F9C;
}

permute(_id_8B462903A1F84F9C, _id_403C537CB8E90B93, _id_4C84BD9AF981DB1A) {
  if(!isDefined(level.escapepathpermutations))
    level.escapepathpermutations = [];

  if(_id_403C537CB8E90B93 == _id_4C84BD9AF981DB1A)
    printpermute(_id_8B462903A1F84F9C, _id_4C84BD9AF981DB1A);

  for(_id_AC0E594AC96AA3A8 = _id_403C537CB8E90B93; _id_AC0E594AC96AA3A8 <= _id_4C84BD9AF981DB1A; _id_AC0E594AC96AA3A8++) {
    _id_8B462903A1F84F9C = swapviaarraylocations(_id_8B462903A1F84F9C, _id_403C537CB8E90B93, _id_AC0E594AC96AA3A8);
    permute(_id_8B462903A1F84F9C, _id_403C537CB8E90B93 + 1, _id_4C84BD9AF981DB1A);
    _id_8B462903A1F84F9C = swapviaarraylocations(_id_8B462903A1F84F9C, _id_403C537CB8E90B93, _id_AC0E594AC96AA3A8);
  }
}

is_player_looking_at_camera(start, angles, _id_75BEA58D65510615, _id_E288D7904FBCF050) {
  if(scripts\engine\utility::within_fov(start, angles, _id_E288D7904FBCF050.origin, cos(7.5)))
    return 1;
  else
    return 0;
}

is_player_looking_at(start, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  self endon("death");
  self endon("disconnect");
  self endon("leave_cam");

  if(!isDefined(dot))
    dot = 0.8;

  player = self;
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  _id_DEE6508B0BA437C5 = player getplayerangles();
  _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
  _id_334AF980E8C1A3AD = vectordot(forward, _id_70222FBC47330166);

  if(_id_334AF980E8C1A3AD < dot)
    return 0;

  if(isDefined(_id_95BFA6EAF973D593))
    return 1;

  return scripts\engine\trace::ray_trace_detail_passed(start, end, _id_75BEA58D65510615, scripts\engine\trace::create_default_contents(1));
}

check_looking_at(_id_3447DD0CDCD69308) {
  self notify("one_instance_for_" + self.model);
  self endon("one_instance_for_" + self.model);
  level endon("end_target_door_watcher_thread");

  if(isDefined(_id_3447DD0CDCD69308))
    wait(_id_3447DD0CDCD69308);
  else
    waitframe();

  level.cam_target.finalstr.model hudoutlineenable("outlinefill_nodepth_red");

  for(;;) {
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

init_camera_interaction() {
  _id_71332A5B74214116::register_interaction("cam_interaction", "null", undefined, ::camhint, ::camactivation, 0, 0, ::caminit);
}

camhint(_id_DF071553D0996FF9, player) {
  if(istrue(level.door_unlocked))
    return "";

  if(_id_DF071553D0996FF9.camstr.bval != 1)
    return &"CP_LAB/LOCKED";

  if(isDefined(_id_DF071553D0996FF9.hacker))
    return &"CP_LAB/LOCKED";

  if(!istrue(level.sequence_locked))
    return &"CP_LAB/LOCKED";

  return &"CP_LAB/ENTER_CAMERAS";
}

camactivation(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(_id_DF071553D0996FF9.camstr.bval != 1) {
    return;
  }
  if(!istrue(level.sequence_locked)) {
    return;
  }
  if(istrue(level.door_unlocked)) {
    player iprintln(" ^7YOU'VE ALREADY FINISHED THIS PUZZLE");
    return;
  }

  if(isDefined(_id_DF071553D0996FF9.hacker)) {
    player iprintln("^7" + _id_DF071553D0996FF9.hacker + " ^3 IS ALREADY ACCESSING THE CAMERAS...Try again later");
    return;
  }

  if(!isDefined(_id_DF071553D0996FF9.camstr.angles))
    _id_DF071553D0996FF9.camstr.angles = (0, 0, 0);

  player.enteredcamera = 1;
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0, 0);
  player notify("enter_cam");
  _id_DF071553D0996FF9.hacker = player;
  level.playeraccessinglaptops = 1;
  player.og_origin = player.origin;
  player.og_angles = player getplayerangles();
  player.og_stance = player getstance();
  fwd = anglesToForward(_id_DF071553D0996FF9.camstr.angles);
  _id_01F7736673CDA8D6 = vectorNormalize(_id_DF071553D0996FF9.camstr.origin - player getorigin());
  dot = vectordot(fwd, _id_01F7736673CDA8D6);
  tag = spawn("script_model", player.origin);
  tag setModel("tag_player");
  tag.origin = _id_DF071553D0996FF9.camstr.origin;
  tag.angles = _id_DF071553D0996FF9.camstr.angles;
  put_player_on_cam(tag, player, _id_DF071553D0996FF9);
  level.cam_hud = snake_door_cam_hud(player);

  while(player useButtonPressed()) {
    if(!istrue(player.enteredcamera)) {
      break;
    }

    wait 0.05;
  }

  waittill_player_exits_cam(player);
  _id_1B9B8DAF429DD199 = tag.origin + anglesToForward(tag.angles) * -20;
  player.enteredcamera = undefined;

  if(!istrue(player.enteredcamera))
    tag moveTo(_id_1B9B8DAF429DD199, 0.05);
  else
    tag moveTo(_id_1B9B8DAF429DD199, 0.5, 0.125);

  wait 0.25;
  player notify("leave_cam");

  foreach(_id_A0DDCCC8DA0CA6AB in level.cam_hud)
  _id_A0DDCCC8DA0CA6AB destroy();

  level thread static_burst(0.125, player);
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "static_faded_in");
  scripts\cp\utility::do_wait_any();
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0.8, 0);
  level notify("vision_set_change_request", undefined, player, 0.5, "snake_cam");
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0);
  setsaveddvar("r_mbRadialOverrideDistortion", 0);
  setsaveddvar("r_mbRadialOverrideRadius", 0);
  setsaveddvar("r_mbRadialOverrideStrength", 0);
  wait 0.1;
  remove_player_from_cam(player);
  _id_DF071553D0996FF9.hacker = undefined;
  level.playeraccessinglaptops = undefined;
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0, 6.0);
}

remove_door_snake_cam_ability() {
  foreach(struct in self.cam_structs) {
    if(isDefined(struct)) {
      struct notify("stop_snake_cam");
      struct scripts\cp\utility::remove_cursor_hint();
    }
  }
}

unlock_pap_and_ww() {
  level waittill("unlock_pap_and_epic_weapon");
  level notify("delete_sequence_timer_thread");
  iprintln(" ^7YOU HAVE UNLOCKED AN EPIC WEAPON AND PACK - A -PUNCH ");
  level.pap_unlocked = 1;
  _id_70DAB3207FB65169 = scripts\engine\utility::getStructArray("weapon_pickup", "script_noteworthy");

  foreach(struct in _id_70DAB3207FB65169) {
    if(isDefined(struct.script_parameters)) {
      name = _id_74502A9E0EF1F19C::getcompletenameforweapon(struct.script_parameters + "_mp");
      weapon = spawn("weapon_" + name, struct.origin);
      weapon itemweaponsetammo(weaponclipsize(name), weaponmaxammo(name));
    }
  }
}

snake_cam_control(player) {
  player endon("leave_cam");
  og_angles = self.angles;
  _id_DDB680F3984C4777 = -90;
  _id_A5337F8300110201 = 90;
  _id_CB6680317BE1E374 = 90;
  _id_0AAE6A37F78B5674 = 90;
  _id_183D5EEC52A67366 = og_angles[1] - _id_CB6680317BE1E374;
  _id_3C5DF5BF59ED9678 = og_angles[1] + _id_CB6680317BE1E374;
  _id_F7DC3A5FD9572B94 = og_angles[2] - _id_0AAE6A37F78B5674;
  _id_2EC0815DFA0F672E = og_angles[2] + _id_0AAE6A37F78B5674;
  _id_827ABACD5CA8F6B3 = 20;
  _id_594240552B896878 = 90;
  _id_440EBEEB83BD05A8 = 0.6;
  _id_75EB1524AFEB7F2B = 0.8;
  _id_C9FF6EEAAF645CEE = 10;
  _id_2FCA29730A69EE8A = 4;
  _id_E47AE22EC47FCEDB = 1.2;
  _id_D296B0EAF4A6B00F = [0, 0];
  _id_D5E6310914396AC3 = 0.2;
  _id_848E35F763CE65B0 = 0.2;
  _id_91AB80BC6772504D = 0;

  for(;;) {
    _id_9DBC893FB4BE54F2 = self.angles;
    _id_B4F55166F66361E9 = player.cam_ent.angles;
    input = player getnormalizedmovement();
    input = [-1, 1];
    _id_98EA5AFB293A76A2 = 0;
    _id_0E2DDA8FF32BB022 = (input[0], input[1], 0);
    _id_0E2DDA8FF32BB022 = length(_id_0E2DDA8FF32BB022);
    _id_5EB5724F78D37C4C = scripts\engine\math::factor_value(_id_848E35F763CE65B0, _id_D5E6310914396AC3, _id_0E2DDA8FF32BB022);
    _id_D296B0EAF4A6B00F[0] = scripts\engine\math::lerp(_id_D296B0EAF4A6B00F[0], input[0], _id_5EB5724F78D37C4C);
    _id_D296B0EAF4A6B00F[1] = scripts\engine\math::lerp(_id_D296B0EAF4A6B00F[1], input[1], _id_5EB5724F78D37C4C);

    if(_id_9DBC893FB4BE54F2[0] > 0 && _id_D296B0EAF4A6B00F[0] < 0)
      _id_13A3FD6DDFA8548F = 1 - scripts\engine\math::normalize_value(_id_A5337F8300110201 * _id_440EBEEB83BD05A8, _id_A5337F8300110201, _id_9DBC893FB4BE54F2[0]);
    else if(_id_9DBC893FB4BE54F2[0] < 0 && _id_D296B0EAF4A6B00F[0] > 0)
      _id_13A3FD6DDFA8548F = scripts\engine\math::normalize_value(_id_DDB680F3984C4777, _id_DDB680F3984C4777 * _id_440EBEEB83BD05A8, _id_9DBC893FB4BE54F2[0]);
    else
      _id_13A3FD6DDFA8548F = 1;

    if(_id_9DBC893FB4BE54F2[1] > og_angles[1] && _id_D296B0EAF4A6B00F[1] < 0)
      _id_8366082D034C6132 = 1 - scripts\engine\math::normalize_value(_id_3C5DF5BF59ED9678 - _id_CB6680317BE1E374 * _id_75EB1524AFEB7F2B, _id_3C5DF5BF59ED9678, _id_9DBC893FB4BE54F2[1]);
    else if(_id_9DBC893FB4BE54F2[1] < og_angles[1] && _id_D296B0EAF4A6B00F[1] > 0)
      _id_8366082D034C6132 = scripts\engine\math::normalize_value(_id_183D5EEC52A67366, _id_183D5EEC52A67366 + _id_CB6680317BE1E374 * _id_75EB1524AFEB7F2B, _id_9DBC893FB4BE54F2[1]);
    else
      _id_8366082D034C6132 = 1;

    _id_9210CEACE4810322 = _id_D296B0EAF4A6B00F[1] * -1;
    _id_181570543B8DA6F7 = _id_9DBC893FB4BE54F2[1] + _id_2FCA29730A69EE8A * _id_9210CEACE4810322 * _id_8366082D034C6132;

    if(_id_181570543B8DA6F7 > og_angles[1])
      _id_98EA5AFB293A76A2 = scripts\engine\math::normalized_float_smooth_out(scripts\engine\math::normalize_value(og_angles[1], _id_3C5DF5BF59ED9678, _id_181570543B8DA6F7)) * -1;

    if(_id_181570543B8DA6F7 < og_angles[1])
      _id_98EA5AFB293A76A2 = 1 - scripts\engine\math::normalized_float_smooth_in(scripts\engine\math::normalize_value(_id_183D5EEC52A67366, og_angles[1], _id_181570543B8DA6F7));

    _id_A810B9620521C338 = input[1];
    _id_D7F62313FFE99D1F = og_angles[2] + _id_594240552B896878 * _id_98EA5AFB293A76A2;
    _id_2EC0815DFA0F672E = _id_2EC0815DFA0F672E * _id_98EA5AFB293A76A2;
    _id_181570543B8DA6F7 = clamp(_id_181570543B8DA6F7, _id_183D5EEC52A67366, _id_3C5DF5BF59ED9678);
    _id_74EEDD477F94F3A3 = _id_D296B0EAF4A6B00F[0] * -1;
    _id_6BF51480C3252112 = _id_9DBC893FB4BE54F2[0] + _id_E47AE22EC47FCEDB * _id_74EEDD477F94F3A3 * _id_13A3FD6DDFA8548F;
    _id_BC4B977758B3324E = _id_DDB680F3984C4777;
    _id_2F22DF6828A1BCB0 = _id_A5337F8300110201;
    _id_6BF51480C3252112 = clamp(_id_6BF51480C3252112, _id_BC4B977758B3324E, _id_2F22DF6828A1BCB0);
    _id_6612315290576B0F = (_id_6BF51480C3252112, _id_181570543B8DA6F7, _id_D7F62313FFE99D1F);
    _id_122923B7FD027A6F = length(_id_6612315290576B0F - self.angles);
    _id_122923B7FD027A6F = scripts\engine\math::normalize_value(0, 1.5, _id_122923B7FD027A6F);
    _id_4D8CD161A8EAADC2 = scripts\engine\math::factor_value(0.0, 0.105, _id_122923B7FD027A6F);
    rumble = scripts\engine\math::factor_value(0.0, 0.08, _id_122923B7FD027A6F);
    volume = scripts\engine\math::factor_value(0.0, 0.2, _id_122923B7FD027A6F);

    if(_id_4D8CD161A8EAADC2 > 0.005)
      earthquake(_id_4D8CD161A8EAADC2, 0.07, player.origin, 2000);

    if(rumble > 0.0001) {
      if(!_id_91AB80BC6772504D) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        _id_91AB80BC6772504D = 1;
      }
    } else if(_id_91AB80BC6772504D) {
      self.rumbleent stoprumble("steady_rumble");
      _id_91AB80BC6772504D = 0;
    }

    height = 1 - rumble;
    height = height * 1000;
    self.rumbleent.origin = player getEye() + (0, 0, height);
    self.angles = _id_6612315290576B0F;
    _id_1B9B8DAF429DD199 = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    player.cam_ent.origin = _id_1B9B8DAF429DD199;
    player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

put_player_on_cam(tag, player, _id_DF071553D0996FF9) {
  _id_1B9B8DAF429DD199 = tag.origin + anglesToForward(tag.angles) * 12 - (0, 0, 55);
  player.cam_ent = tag;
  player.isusingcamera = 1;
  player.currentcamera = _id_DF071553D0996FF9.camstr;
  player.cameratarget = _id_DF071553D0996FF9.camstr.targetname;
  player _id_3B64EB40368C1450::set("player_on_cam", "fire", 0);
  player cameraunlink();
  player cameralinkTo(player.cam_ent, "tag_player", 1);
  player playerlinkweaponviewtodelta(player.cam_ent, "tag_player", 1);
  player playerlinkedsetviewznear(0);
  player setplayerangles(tag.angles);
  thread watchforcameralookatothercameras(player, _id_DF071553D0996FF9);
}

watchforcameralookatothercameras(player, _id_DF071553D0996FF9) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  foreach(_id_1F1C8D335BF8F19F in level.hack_structs) {
    _id_1F1C8D335BF8F19F.model thread watchforplayerlookat(player, _id_1F1C8D335BF8F19F);
    _id_1F1C8D335BF8F19F.model thread watchforcameralaunch(player, _id_1F1C8D335BF8F19F, _id_DF071553D0996FF9);
  }
}

watchforcameralaunch(player, _id_1F1C8D335BF8F19F, _id_DF071553D0996FF9) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");
  player notifyonplayercommand("enter_hack_cam", "+attack");

  for(;;) {
    player waittill("enter_hack_cam");

    if(istrue(self.outlined))
      player thread enter_hacked_cam_model(self, _id_1F1C8D335BF8F19F, _id_DF071553D0996FF9);
  }
}

watchforplayerlookat(player, _id_1F1C8D335BF8F19F) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  for(;;) {
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

watchforcurrentcamerahack(player, currentcamera, cameratarget) {
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
  return;
}

watchforplayerfirepress(player) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");
  player notifyonplayercommand("enter_hack_cam", "+attack");

  for(;;) {
    player waittill("enter_hack_cam");

    if(istrue(self.model.outlined)) {
      player thread enter_hacked_cam(self);
      continue;
    }

    player iprintln("^1 YOU TRIED TO ENTER THE WRONG CAMERA! FAIL!");
    level.cam_target.finalstr.model hudoutlinedisable();
    level notify("override_cooldowns");
    scripts\engine\utility::flag_set("exit_snakecam_immediately");
  }
}

enter_hacked_cam_model(_id_609F3DAE81876C41, _id_1F1C8D335BF8F19F, _id_DF071553D0996FF9) {
  _id_609F3DAE81876C41 hudoutlineenableforclient(self, "outlinefill_nodepth_orange");
  self notify("switch_cams");
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0, 0);
  level thread static_burst(0.1, self);
  self.cam_ent.origin = _id_609F3DAE81876C41.origin;
  self.cam_ent.angles = self.angles;
  self.currentcamera = _id_609F3DAE81876C41;
  _id_1430C2C17D46405F = _id_DF071553D0996FF9.camstr.sequencetype + _id_1F1C8D335BF8F19F.sequencename;

  if(_id_1430C2C17D46405F == _id_DF071553D0996FF9.camstr.finalsequence)
    self iprintln("^4this is the correct Sequence for ^7" + _id_DF071553D0996FF9.camstr.name);

  level notify("sequence_changed", _id_1430C2C17D46405F, _id_DF071553D0996FF9.camstr.name);
  thread watchforcameralookatothercameras(self, _id_DF071553D0996FF9);
}

enter_hacked_cam(_id_2C70181123B48543) {
  _id_2C70181123B48543.model hudoutlineenableforclient(self, "outlinefill_nodepth_orange");
  self notify("switch_cams");
  scripts\cp\utility::outline_fade_alpha_for_index(6, 0, 0);
  level thread static_burst(0.1, self);
  self.cam_ent.origin = _id_2C70181123B48543.origin;
  self.cam_ent.angles = _id_2C70181123B48543.angles;
  self.cameratarget = _id_2C70181123B48543.target;
  self.currentcamera = _id_2C70181123B48543;
  thread watchforcurrentcamerahack(self, self.currentcamera, self.cameratarget);
}

watchforlookathackcam(player, _id_2C70181123B48543, cameraent) {
  player endon("death");
  player endon("disconnect");
  player endon("leave_cam");
  player endon("switch_cams");

  for(;;) {
    wait 0.1;

    if(player worldpointinreticle_circle(self.origin, 10, 2000)) {
      if(istrue(self.outlined)) {
        self hudoutlineenableforclient(player, "outlinefill_nodepth_cyan");
        continue;
      }

      if(isDefined(player.cameratarget) && isDefined(_id_2C70181123B48543.name)) {
        if(player.cameratarget.name == _id_2C70181123B48543.name) {
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

remove_player_from_cam(player) {
  player unlink();
  player cameraunlink();
  player controlsunlink();
  player setOrigin(player.og_origin);
  player setplayerangles(player.og_angles);
  player setstance(player.og_stance);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("player_on_cam");
  player.isusingcamera = 0;
  player.cameraused = undefined;
  player.cameratarget = undefined;

  foreach(_id_2C70181123B48543 in level.hack_structs) {
    if(istrue(_id_2C70181123B48543.model.outlined)) {
      _id_2C70181123B48543.model hudoutlinedisableforclient(player);
      _id_2C70181123B48543.model.outlined = undefined;
    }
  }
}

waittill_player_exits_cam(player) {
  for(;;) {
    if(player_is_trying_to_exit_camera(player)) {
      break;
    } else if(!istrue(player.enteredcamera)) {
      break;
    } else if(!istrue(level.sequence_locked)) {
      break;
    } else if(istrue(level.unlockedelevator)) {
      break;
    } else if(istrue(self.disabled)) {
      break;
    } else
      waitframe();
  }
}

player_is_trying_to_exit_camera(player) {
  return player useButtonPressed() || player fragButtonPressed() || player meleeButtonPressed() || player buttonPressed("BUTTON_B") || player jumpbuttonPressed() || player buttonPressed("BUTTON_LSTICK") || player buttonPressed("BUTTON_RSTICK");
}

static_burst(duration, player) {
  fade_time = 0.25;
  duration = scripts\engine\utility::ter_op(isDefined(duration), duration, 0.5);
  _id_C1B9F1A971D8ED37 = scripts\cp\utility::create_client_overlay("white", 1, player);
  _id_C1B9F1A971D8ED37.alpha = 0;
  _id_C1B9F1A971D8ED37 fadeovertime(fade_time);
  _id_C1B9F1A971D8ED37.alpha = 1;
  wait(fade_time);
  level notify("static_faded_in");
  wait(duration);
  _id_C1B9F1A971D8ED37 fadeovertime(fade_time);
  _id_C1B9F1A971D8ED37.alpha = 0;
  wait(fade_time);
  level notify("static_faded_out");
  _id_C1B9F1A971D8ED37 destroy();
}

snake_door_cam_hud(player) {
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
  _id_083A337B15031DAB = scripts\cp\utility::create_client_overlay("nightvision_overlay_goggles_grain", 1, player);
  level notify("vision_set_change_request", "snake_cam", player);
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0.5);
  setsaveddvar("r_mbRadialOverrideDistortion", 0.2);
  setsaveddvar("r_mbRadialOverrideRadius", -0.75);
  setsaveddvar("r_mbRadialOverrideStrength", 0.011);
  return [crosshair, _id_083A337B15031DAB, overlay];
}

fake_effects(start, end, model, player) {
  for(;;) {
    start = model.origin;
    end = model.origin + anglesToForward(player.angles) * 1000;
    wait 1;
  }
}

draw_line_for_time_endon_death(_id_6C12713F33727294, org2, r, g, b, timer) {
  timer = gettime() + timer * 1000;

  while(gettime() < timer)
    wait 0.05;
}

draw_angles_on_line(start, end, r, g, b, timer, model) {
  model endon("death");
  _id_04DFFBF84669F6C5 = spawn("script_model", start);
  _id_04DFFBF84669F6C5 moveTo(end, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < timer; _id_AC0E594AC96AA3A8++) {
    thread scripts\engine\utility::draw_capsule(_id_04DFFBF84669F6C5.origin, 3, 3, model.angles, (1, 0, 0), 0, 1);
    wait 0.05;
  }

  _id_04DFFBF84669F6C5 delete();
}