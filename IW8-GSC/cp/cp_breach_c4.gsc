/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_breach_c4.gsc
***********************************************/

main() {
  script_model_anims();
}

setup_c4(var_0) {
  if(isDefined(var_0)) {
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_1 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60", &"_encstr_82FE1A201FB8570BB1BB7B7D1FC9456748F779C8A697E33561837E05", 25, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BD1805CB69C063", 250, 45, 70, 45);
    var_2 = spawnStruct();
    var_2.origin = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
    var_2.angles = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_1.scenenode = var_2;
    var_1 scripts\engine\utility::ent_flag_init("_encstr_A3F10B09271F67380E3EA18B5C");
    var_1 scripts\engine\utility::ent_flag_init("_encstr_928C0C273211552880ED1089577C");

    if(isDefined(var_1))
      var_1 thread c4_breach_think(var_0);

    return var_1;
  } else
    return undefined;
}

c4_breach_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    self makeunusable();
    level notify("_encstr_92F708A803EA9FCF06FD", var_1);

    if(istrue(self.bskipplantsequence)) {
      if(isDefined(level.brmini_createc130pathstruct))
        self[[level.brmini_createc130pathstruct]](var_1);

      return;
    }

    level thread force_bleedout_all_downed_players(var_1);
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.scenenode.origin);
    var_2.angles = self.scenenode.angles;
    var_2 setModel("_encstr_B1BE11D5BB5A3AFFE092C9231DE1B07D710197");
    var_1._id_140AE = 1;
    var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_92130BA089B1A0B29E8F23EA62", 1);
    var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_2, "_encstr_B80D08A2AAC19BC0DD58");
    var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_AA45092A9BB0E33D20ED4C", 1);
    var_5 = 0;

    if(istrue(var_1.isjuggernaut))
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_3, var_4], "_encstr_AA45092A9BB0E33D20ED4C", undefined, undefined, undefined, undefined, undefined, 1);
    else
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_3, var_4], "_encstr_AA45092A9BB0E33D20ED4C");

    if(var_5) {
      scripts\engine\utility::ent_flag_set("_encstr_A3F10B09271F67380E3EA18B5C");
      level thread c4_explode(self, var_2);
      level thread force_ai_to_drop_thermites(var_1);
      var_1._id_140AE = undefined;
      return;
    } else {
      if(isDefined(var_2))
        var_2 delete();

      self makeusable();
    }

    var_1._id_140AE = undefined;
    var_3 = undefined;
    var_4 = undefined;
  }
}

force_bleedout_all_downed_players(var_0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_95EB1360E9738F1985B3DB3733366FC1532B30BB20");
}

force_ai_to_drop_thermites(var_0) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_AB420F7006CA59968B277B076B2166C08C");
}

c4_explode(var_0, var_1) {
  var_1 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  var_2 = gettime();
  var_3 = int(var_2 + 5000);
  var_4 = var_3 - var_2;

  if(istrue(var_0.bskipplantsequence))
    var_4 = 0;

  while(var_4 > 0) {
    var_2 = gettime();
    var_4 = var_3 - var_2;

    if(var_4 < 1500) {
      if(var_4 <= 250) {
        if(soundexists("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E"))
          var_1 playSound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
      } else if(var_4 < 500) {
        if(soundexists("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74"))
          var_1 playSound("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74");
      } else if(var_4 < 1500) {
        if(soundexists("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7"))
          var_1 playSound("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7");
      } else if(soundexists("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C"))
        var_1 playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.25;
    } else if(var_4 < 3500) {
      if(soundexists("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C"))
        var_1 playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.5;
    } else {
      if(soundexists("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF"))
        var_1 playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");

      wait 1.0;
    }

    if(var_4 < 0) {
      break;
    }
  }

  if(!istrue(var_0.bskipplantsequence)) {
    physicsexplosionsphere(var_1.origin, 200, 100, 3);
    var_1 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AF560CCB78E2984063BA0FF1127B");
  }

  var_0 scripts\engine\utility::ent_flag_set("_encstr_928C0C273211552880ED1089577C");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_92130BA089B1A0B29E8F23EA62"] = #animtree;
  level.scr_anim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AA45092A9BB0E33D20ED4C"] = % _encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A;
  level.scr_animname["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AA45092A9BB0E33D20ED4C"] = "_encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A";
  level.scr_eventanim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AA45092A9BB0E33D20ED4C"] = "_encstr_82F710FD2F3B379237983F8160894BCF511B";
  level.scr_animtree["_encstr_B80D08A2AAC19BC0DD58"] = #animtree;
  level.scr_anim["_encstr_B80D08A2AAC19BC0DD58"]["_encstr_AA45092A9BB0E33D20ED4C"] = % _encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0;
  level.scr_animname["_encstr_B80D08A2AAC19BC0DD58"]["_encstr_AA45092A9BB0E33D20ED4C"] = "_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0";
}