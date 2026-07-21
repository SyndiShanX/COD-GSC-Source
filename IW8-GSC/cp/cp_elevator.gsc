/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_elevator.gsc
***********************************************/

init_elevator() {
  init_elevator_animations();
  var_0 = getEntArray("_encstr_86F80AB1A5661DFA8D634BC1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = getEnt("_encstr_A55D0B90626F1116B7673DA54C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = getEnt("_encstr_96430B3AA4F5BB26B90ACD7A3B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_2))
    var_2 delete();

  var_3 = getEntArray("_encstr_ADE911A9B756198F3A3A757BBBB1BF4323AD46", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = getEntArray("_encstr_8BEB0BC00A906B09B883AD772D", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = getEnt("_encstr_8AB610B5883E0C6FAD8D48F7301F1AAAD973", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_5))
    var_5 delete();

  var_1 setModel("_encstr_8FD6176D8029AD48A03BD9E3C0A635F17533B823B57577820D");
  var_1 useanimtree(level.scr_animtree["_encstr_8A17090D51C9BB06B1286B"]);
  var_1.animname = "_encstr_8A17090D51C9BB06B1286B";
  level.tower_elevator = var_1;
  var_6 = var_3[0];
  level.tower_elevator.interactions = [];

  foreach(var_8 in var_3) {
    var_8 setHintString(&"_encstr_B27015568F79D3395EE34777076DB077B9F6DEED04418D");
    var_8 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
    var_8 sethintdisplayrange(300);
    var_8 sethintdisplayfov(65);
    var_8 setuserange(90);
    var_8 setusefov(65);
    var_8 sethintonobstruction("_encstr_BD1805CB69C063");
    var_8 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
    var_8 sethintrequiresholding(1);
    var_8 makeusable();
    var_8 linkTo(level.tower_elevator);
    level.tower_elevator.interactions = scripts\engine\utility::array_add(level.tower_elevator.interactions, var_8);
  }

  scripts\engine\utility::array_call(var_4, ::solid);
  scripts\engine\utility::array_call(var_4, ::linkto, level.tower_elevator);
  scripts\engine\utility::array_call(var_4, ::delete);
  level.tower_elevator.clip = var_0;
  scripts\engine\utility::array_call(level.tower_elevator.clip, ::solid);
  scripts\engine\utility::array_call(level.tower_elevator.clip, ::linkto, level.tower_elevator);
  level.tower_elevator.state = 1;
  level.tower_elevator.current_floor = 0;
  level.tower_elevator.doors_opened = 1;
  level.tower_elevator.user_triggered = undefined;
  level.tower_elevator.locked = undefined;
  level.tower_elevator.locked_behind_interaction = undefined;
  scripts\engine\utility::array_thread(level.tower_elevator.interactions, ::use_elevator, level.tower_elevator);
  level.tower_elevator.mover = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.tower_elevator.origin);
  level.tower_elevator.mover setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.tower_elevator linkTo(level.tower_elevator.mover);
  level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "_encstr_A9B00E56D8953B0B8EB793F5DBE0959B");
  wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"]));
}

anim_check_loop() {
  for(;;) {
    scripts\common\anim::anim_single_solo(self, "_encstr_A9B00E56D8953B0B8EB793F5DBE0959B");
    wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"]));
    scripts\common\anim::anim_single_solo(self, "_encstr_9BE00F7D41423389349F6ADEFB418F4761");
    wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_9BE00F7D41423389349F6ADEFB418F4761"]));
  }
}

use_elevator(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_8A2D0DBB73CF6707606F9BFA8B406A");
  self endon("_encstr_8A2D0DBB73CF6707606F9BFA8B406A");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self playSound("_encstr_86DF1D37B1B9AFC60EFAACD82BB32CE87B93AF31574747DEE67DE027CA6E37");

    if(!isPlayer(var_1)) {
      continue;
    }
    if(istrue(var_0.locked)) {
      var_1 iprintln("_encstr_A7DA15BBA5AFF8D7C8E37A96B918E5765187C797E32506");
      continue;
    }

    if(istrue(var_0.locked_behind_interaction)) {
      var_1 iprintln("_encstr_A245412FC88022B7F6E46E10B09CCA401BDEB15B5919764014D83A5AB32CA3CA808E43CA08D4BB4B3A8D1A10E8BD10EA37B17BC6DA08D1D059102A6356B385A3BDE402");
      continue;
    }

    var_0.user_triggered = 1;

    if(!istrue(var_0.doors_opened)) {
      var_0 = change_state(var_0, 0);
      level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "_encstr_A9B00E56D8953B0B8EB793F5DBE0959B");
      self playSound("_encstr_88341536A9B2EF3A8B091DE2812BA6A13043E98F18C5ED");
      wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"]));
      var_0 = change_state(var_0, 1);
      var_1 iprintln("_encstr_837C1DBE85E2B85755F10A03A120B7373AA1300D39A08527FCF1B3FA6BAFDA");
      continue;
    }

    var_0 thread push_players_out_of_the_way();
    var_0 = change_state(var_0, 2);
    level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "_encstr_9BE00F7D41423389349F6ADEFB418F4761");
    self playSound("_encstr_828C169B2E96014E0377DBC1B74B87E03FC2861195CF2875");
    wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_9BE00F7D41423389349F6ADEFB418F4761"]));
    var_0 = change_state(var_0, 3);
  }
}

change_state(var_0, var_1) {
  var_0.state = var_1;
  var_0 = var_0 set_properties_based_on_state(var_1, var_0);
  return var_0;
}

set_properties_based_on_state(var_0, var_1) {
  if(!isDefined(var_0) || !isint(var_0) || (var_0 < 0 || var_0 > 4)) {
    return;
  }
  switch (var_0) {
    case 0:
      break;
    case 1:
      self.doors_opened = 1;
      self.user_triggered = undefined;
      self.locked = undefined;

      foreach(var_3 in var_1.interactions)
      var_3 setHintString(&"_encstr_B27015568F79D3395EE34777076DB077B9F6DEED04418D");

      break;
    case 2:
      self.doors_opened = undefined;
      break;
    case 3:
      foreach(var_3 in var_1.interactions)
      var_3 setHintString(&"_encstr_AD96140D0A7D35A29225D251E5887AE992F5D328519C");

      if(istrue(self.user_triggered)) {
        var_1 = change_state(var_1, 4);
        var_1 = var_1 move_elevator();
      }

      break;
    case 4:
      self.locked = 1;
      break;
    default:
      break;
  }

  return var_1;
}

push_players_out_of_the_way() {
  self notify("_encstr_A10A1C8B233633411879C9C9735012A7505B43E1C80437433043FFCF1320");
  self endon("_encstr_A10A1C8B233633411879C9C9735012A7505B43E1C80437433043FFCF1320");
}

move_elevator() {
  var_0 = self;
  var_0 playSound("_encstr_8DDC1D9B36CD7D8D1CD7598DB29DC2A3BD4EAF4BCDAFBA6EACAF6E8E2C2747");
  var_0 playLoopSound("_encstr_A6471AE6C69BEB6C837DB2B1CAB3161DB727FAA5B9FA5D6E59BE1B07");

  if(var_0.current_floor == 1)
    var_0.mover moveTo(var_0.origin + (0, 0, -1448.01), 4);
  else
    var_0.mover moveTo(var_0.origin + (0, 0, 1448.01), 4);

  wait 4;
  iprintln("_encstr_8A0A17B1E2031D18FED44775A863E0D7831AB0295AB7C0C8C6");
  var_0 playSound("_encstr_88441C77F31571364389D9E03283FFE0ED5AA7DB963178063F6113EBBAF3");
  var_0 stoploopsound("_encstr_A6471AE6C69BEB6C837DB2B1CAB3161DB727FAA5B9FA5D6E59BE1B07");

  if(var_0.current_floor == 1)
    var_0.current_floor = 0;
  else
    var_0.current_floor = 1;

  var_0 = change_state(var_0, 0);
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_A9B00E56D8953B0B8EB793F5DBE0959B");
  var_0 playSound("_encstr_88341536A9B2EF3A8B091DE2812BA6A13043E98F18C5ED");
  wait(getanimlength(level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"]));
  var_0 = change_state(var_0, 1);
  return var_0;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_elevator_animations() {
  level.scr_animtree["_encstr_8A17090D51C9BB06B1286B"] = #animtree;
  level.scr_model["_encstr_8A17090D51C9BB06B1286B"] = "_encstr_8FD6176D8029AD48A03BD9E3C0A635F17533B823B57577820D";
  level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"] = % _encstr_B83C1A4E33893F60BF4B91ED43015BC1BD128DFDB07BC00F07FF3316;
  level.scr_animname["_encstr_8A17090D51C9BB06B1286B"]["_encstr_A9B00E56D8953B0B8EB793F5DBE0959B"] = "_encstr_B83C1A4E33893F60BF4B91ED43015BC1BD128DFDB07BC00F07FF3316";
  level.scr_anim["_encstr_8A17090D51C9BB06B1286B"]["_encstr_9BE00F7D41423389349F6ADEFB418F4761"] = % _encstr_83E21BC6E0EBC127EDE0EB5636CA67C23AF64E237BEDC9F5C636F6E6B2;
  level.scr_animname["_encstr_8A17090D51C9BB06B1286B"]["_encstr_9BE00F7D41423389349F6ADEFB418F4761"] = "_encstr_83E21BC6E0EBC127EDE0EB5636CA67C23AF64E237BEDC9F5C636F6E6B2";
}