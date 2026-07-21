/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\milbase\ai_flare.gsc
***************************************************/

load_fx() {
  level._effect["_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"] = loadfx("_encstr_B44C2A2E959895C7DC6A86BA29B40FBDCA0BBD823398CACFA89B0A0376016F72A8EB3A3745E0526717F3020B");
  level._effect["_encstr_83D610ECBE3B362DFDFA60D0F113FD09972C"] = loadfx("_encstr_BAE33ECE661ECB96DDC1F2D895ECAC36F22BB6C42C6EDC975E3BCC1EAF5AC663EA6BD2E6161D5A7B73D766B185E4ACF5D8585DCD3643F58EE4C2A51BB89D990F");
  level._effect["_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"] = loadfx("_encstr_84DF2B2B8173EE0CE011471CB330D72B30B852A2E84C8F404AA506782FC01D2BC5311BA9F3A647BC686D2EE659");
  level._effect["_encstr_B60912BA4A482A6AE1B1732F5BE11FBB999A42E3"] = loadfx("_encstr_A32F31DBCDC30E9148EA3106DBB2ACE29C533BC6AF6FB15D5088F54E9138ED9E74FDF38F13999A1A28F6ED94493824C6CC057B");
  level._effect["_encstr_AC3C1560B2C867705F9AD5477277B9D132FA30C0FAA54D"] = loadfx("_encstr_B6D13767330FF24BDD70CBEEB258C1F2AF2BE10E367B795BED27A3C2C9BCEC333CFADADBE43A58277D56E1071BB7B94B7BB9D713B571EC663C");
  script_model_anims();
  level._id_11E67 = gettime();
  level._id_11D34 = [];
}

run_to_and_launch_flare(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4041BE8B236AC0EBDC91DBE8EDE7D9B95164E4CF2AFB9E00BDDE69527");
  var_0.fired = 0;
  thread handle_ai_launcher_death(var_0);
  self.going_to_object = var_0;
  var_2 = self.goalradius;
  scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
  self._id_11E51 = self.never_kill_off;
  self.never_kill_off = 1;
  self.matchdata_logattackerkillevent = self.dont_kill_off;
  self.dont_kill_off = 1;
  run_to_launcher(var_0);
  enter_launcher(var_0);
  fire_launcher(var_0);
  exit_launcher(var_0);
  self.goalradius = var_2;
  self.going_to_object = undefined;

  if(isDefined(var_1)) {
    self.goalradius = 128;
    var_0.operator = self;
    thread _id_11D2B(var_0);
  }

  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self._id_11E51))
    self.never_kill_off = self._id_11E51;

  if(isDefined(self.matchdata_logattackerkillevent))
    self.dont_kill_off = self.matchdata_logattackerkillevent;
}

_id_11D2B(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_B4041BE8B236AC0EBDC91DBE8EDE7D9B95164E4CF2AFB9E00BDDE69527");
  var_0.operator = undefined;
  var_0._id_1200B = gettime() + 45000;
}

enter_launcher(var_0) {
  ai_anim("_encstr_8A2511B9199CEBADB7C98E16C9D756734759C9", 0.7);
  var_0 scriptmodelplayanimdeltamotion("_encstr_85FD155DB5CA572B8DA7B8B00BCC814561DDC05E4B52D5", "_encstr_B6DF07A09FB6288BD6", 0.7);
  wait 0.5;
  var_0 showpart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  wait 0.2;
}

fire_launcher(var_0) {
  ai_anim("_encstr_AD8512DA81D6D6E8D59BABB9B51944FB181E4288", 0.4);

  if(var_0.script_noteworthy == "_encstr_B1A9062B08CFA39F")
    var_0 thread launch_illumination_flare();
  else
    var_0 thread launch_mortar(undefined, undefined, self);

  var_0 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  wait 0.4;
  self notify("_encstr_BEE90C83389B560A91E8578D68A3");
  var_0.fired = 1;
}

exit_launcher(var_0) {
  ai_anim("_encstr_8B8310CD4639FA5BDB93D12C39F5AC1EA51D");
}

reload_launcher(var_0) {
  var_0 scriptmodelplayanimdeltamotion("_encstr_B88A1CD9A2FBC0D03D3F838F3A23381E672B51602A4F8559D51785A1518A");
  ai_anim("_encstr_933A12DC8C93FA6BDE3947B027D79CAC8DDE0B32");
}

run_to_launcher(var_0) {
  var_1 = get_flare_launch_entrance(self, var_0);
  goto_anim_pos(var_1, 0);
}

get_flare_launch_entrance(var_0, var_1) {
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_8A2511B9199CEBADB7C98E16C9D756734759C9");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = var_1 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 = var_1 gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3) + anglesToForward(var_1.angles) * 5;
  var_6.angles = getstartangles(var_4, var_5, var_3);
  var_6.animindex = var_2;
  var_6.xanim = var_3;
  return var_6;
}

ai_anim(var_0, var_1) {
  _id_13A2B();

  if(isDefined(var_1))
    scripts\asm\shared\mp\utility::burningdown(var_0, var_1);
  else
    scripts\asm\shared\mp\utility::burndowntime(var_0);

  _id_12CC2();
}

bleedout_logic(var_0, var_1) {
  _id_13A2B();
  scripts\asm\shared\mp\utility::burningpartlogic(var_0, var_1);
  _id_12CC2();
}

goto_anim_pos(var_0, var_1) {
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.goalradius = 8;
  self.script_radius = 8;
  self setgoalpos(self getclosestreachablepointonnavmesh(var_0.origin));
  _id_143CB(var_0.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self.allowpain = 0;
  self waittill("_encstr_8B7205D9ED5958");

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  self setplayerangles(var_0.angles);
  self forceteleport(var_0.origin, var_0.angles);

  if(istrue(var_1)) {
    self.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
    self.anchor.angles = var_0.angles;
    self linkTo(self.anchor);
  }
}

launch_illumination_flare(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");

  if(!isDefined(var_1))
    var_1 = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);

  var_2 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), "_encstr_8F8D198F054F9B19C5FF15D48ACA3FFE928A4B971F74392FEE200B");
  var_2 show();
  var_3 = 2.25;
  thread movemortar(var_2, var_0, var_1, var_3, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_83D610ECBE3B362DFDFA60D0F113FD09972C"), var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 playsoundonmovingent("_encstr_9A9B1A0F6B1ED2EFB5785AD116250948BCA8CAD8B6C7A42A9040E920");
  wait(var_3);
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A3520A14B7AB97E94C9F8020"), var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_83D610ECBE3B362DFDFA60D0F113FD09972C"), var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 thread flare_mover(var_1);
  var_2 playSound("_encstr_911C184702C222A110C88503793B9FD1505B332310A24D0B1BFB");
  var_2 playSound("_encstr_A2C223630D03C39760A81333E0BB5F6AC197AA1FF889FAFFCB38735790B34BA197B5F652D5");
  wait 0.1;
  var_2 playLoopSound("_encstr_822E20B475971BA745D2B8902ADAEF91DB19BE25F77BC03F2A0B604073336F4E7390");
  wait 8;
  var_2 playSound("_encstr_83A121EFFB9F2B7748F08A132968AF82E10B733F27BFF20FD03B04DDA378CB69CDBDD3");
  wait 2;
  var_2 delete();
}

launch_mortar(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");

  if(isDefined(level.get_mortar_impact_pos))
    var_1 = var_2[[level.get_mortar_impact_pos]](self);

  if(!isDefined(var_1))
    var_1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);

  thread _id_142E2(var_1);
  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), "_encstr_B60E16BB0F39D8F0B2D7959107AB3890D9226136F769881D");
  var_4 show();
  level._id_11D34 = scripts\engine\utility::array_add(level._id_11D34, var_4);
  var_5 = 5;
  var_6 = 1200;

  if(isDefined(var_3))
    var_6 = var_3;

  thread movemortar(var_4, var_0, var_1, var_5, var_6);
  _id_14358(var_4, var_5);

  if(isDefined(var_4)) {
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_4 stoploopsound();
    var_1 = var_4.origin;
    var_7 = (0, 0, 40);

    if(isalive(var_2))
      radiusdamage(var_1 + var_7, 256, 200, 150, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");
    else
      radiusdamage(var_1 + var_7, 256, 200, 150, var_4, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");

    playFX(scripts\engine\utility::getfx("_encstr_AC3C1560B2C867705F9AD5477277B9D132FA30C0FAA54D"), var_1);
    earthquake(0.25, 3, var_1, 2048);
    playrumbleonposition("_encstr_97011287E9A8326880FBF2BF9329BAEB19652317", var_1);
    magicgrenademanual("_encstr_A5EF0A384DEA382F83D76B59", var_1 + (0, 0, 5), (0, 0, 0), 0.05);
    level._id_11D34 = scripts\engine\utility::array_remove(level._id_11D34, var_4);
    var_4 delete();
  } else
    level._id_11D34 = scripts\engine\utility::array_removeundefined(level._id_11D34);
}

_id_14358(var_0, var_1) {
  var_0 endon("_encstr_8F860D2B58E436BCEB2DAD1C2C361D");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setModel("_encstr_A103252B175D960EB6CA373AEBB6BD391D0B4EAF9B34AC36B1F52DD61C4EB7CE5ADC2B46BE60C4");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 playLoopSound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  wait(var_1 - 1.7);
  var_0 playSound("_encstr_8D6815EEACC2E0FAADBDC98EB0C97D4BDC36EDADB4E6CE");
  wait 1.7;
}

flare_mover(var_0) {
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(self)) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveTo((var_1, var_2, var_3), 1);
    wait 1;
  }
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_5 = 1200;

  if(isDefined(var_4))
    var_5 = var_4;

  var_6 = 1 / (var_3 / 0.05);
  var_7 = 0;
  var_8 = undefined;

  while(var_7 < 1) {
    if(isDefined(var_8)) {
      if(var_7 + var_6 < 1) {
        var_0.origin = var_8;
        var_0 notify("_encstr_8F860D2B58E436BCEB2DAD1C2C361D");
        return;
      }
    }

    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_7);
    var_9 = var_7 + var_6;
    var_10 = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_9);
    var_8 = getcombatrecordsupermisc(var_0, var_10);
    var_0 anglemortar();
    var_7 = var_7 + var_6;
    wait 0.05;
  }

  var_0.origin = var_2;
}

getcombatrecordsupermisc(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_1, var_0, var_2);

  if(var_3["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    return var_1;
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

handle_ai_launcher_death(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  self endon("_encstr_BEE90C83389B560A91E8578D68A3");
  var_0 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
}

run_to_and_set_alarm(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = self.goalradius;

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(istrue(var_2.alarm_on)) {
    return;
  }
  self.going_to_object = var_0;
  goto_anim_pos(var_0, 1);
  ai_turnon_alarm(var_2);
  self.goalradius = var_1;
  self.going_to_object = undefined;
  self.script_radius = self.goalradius;
  clear_custom_anim();
}

ai_turnon_alarm(var_0) {
  var_0 scriptmodelplayanim("_encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8");
  ai_anim("_encstr_B4390F9BC839EB99D5CD2B4CDBF07DDB9B");
  alarm_fx_on(var_0);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_85390A0F377AD5E89029E8C0");
  var_0 thread auto_alarm_turnoff(60);
}

auto_alarm_turnoff(var_0) {
  self endon("_encstr_8A490B1DAB279BAC91F5DE3333");
  wait(var_0);
  self makeunusable();
  self scriptmodelplayanim("_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F");
  alarm_fx_off(self);
  scripts\engine\utility::ent_flag_clear("_encstr_85390A0F377AD5E89029E8C0");
  wait 1;
  self makeusable();
}

ai_turnoff_alarm(var_0) {
  var_0 scriptmodelplayanim("_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F");
  ai_anim("_encstr_B8871013A91E57B798DF252A8F98B1CF4C41");
  alarm_fx_off(var_0);
}

alarm_box_player_interaction(var_0, var_1) {
  var_0 makeusable();
  var_0 setHintString(&"_encstr_95B81887C91F49FBC6A43FC768A4F1A1E111AFC02F0F0C6109A5");
  var_0 sethinttag("_encstr_8A150902C868E7C591301A");
  var_0 sethintdisplayrange(128);
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethinticon("_encstr_9A2E1472F83F45A779F9ADA38DE3074E4B18997A30C9");
  var_0 sethintdisplayfov(120);
  var_0 sethintonobstruction("_encstr_BECC055CF3811A");
  var_0 sethintrequiresholding(0);
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 thread alarmbox2_logic(var_0, var_1);
}

toggle_alarm(var_0) {
  var_0.alarm_on = 0;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
    var_0 makeunusable();

    if(var_0.alarm_on) {
      var_0 scriptmodelplayanim("_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F");
      alarm_fx_off(var_0);
    } else {
      scripts\asm\shared\mp\utility::burndowntime("_encstr_B4390F9BC839EB99D5CD2B4CDBF07DDB9B");
      alarm_fx_on(var_0);
      var_0 thread auto_alarm_turnoff(60);
    }

    wait 3;
    var_0 makeusable();
  }
}

attract_agent_to_alarm(var_0, var_1) {
  var_0 endon("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, getEntArray("_encstr_9627098BD859C7D0B63323", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), 512);

  if(isDefined(var_2)) {
    var_2.attracting = 0;
    var_2.fired = 0;
  }

  for(;;) {
    if(istrue(var_1.alarm_on)) {
      while(istrue(var_1.alarm_on))
        wait 1;

      if(isDefined(var_2)) {
        var_2 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");
        var_2.attracting = 0;
      }
    } else {
      if(isDefined(var_2) && !var_2.attracting && !var_2.fired) {
        var_2 thread attract_agent_to_mortar(var_2);
        var_2.attracting = 1;
      }

      var_3 = attract_an_agent(var_0, 2048);

      if(isDefined(var_3)) {
        var_3 run_to_and_set_alarm(var_0);

        if(!var_1.alarm_on)
          wait 2;
        else
          return;
      }
    }

    wait 1;
  }
}

attract_agent_to_mortar(var_0, var_1, var_2) {
  var_0 endon("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");

  for(;;) {
    var_3 = undefined;

    if(isDefined(var_0.operator) && isalive(var_0.operator))
      var_3 = var_0.operator;
    else {
      if(isDefined(var_0._id_1200B) && gettime() < var_0._id_1200B) {
        wait 1;
        continue;
      }

      var_0.operator = undefined;
      var_4 = 1024;

      if(isDefined(var_2))
        var_4 = var_2;

      var_3 = attract_an_agent(var_0, var_4);
    }

    if(isDefined(var_3)) {
      var_3 run_to_and_launch_flare(var_0, var_1);

      if(istrue(var_0.fired)) {
        level notify("_encstr_91310F998D0B3959F51BC2EAB9C643AC19");
        var_0.attracting = 0;
        return;
      } else
        wait 5;
    }

    wait 1;
  }
}

initialize_alarm_box(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  alarm_box_player_interaction(var_2, var_1);
  var_0.alarm_box = var_2;
  var_2 scripts\engine\utility::ent_flag_init("_encstr_85390A0F377AD5E89029E8C0");
  var_2.scenenode = var_0;
}

attract_an_agent(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_3 = !istrue(var_0.ignoreplayers) && scripts\cp\utility::any_player_nearby(var_0.origin, squared(384));

  if(!var_2.size || var_3)
    return undefined;

  var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 4, var_1);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isDefined(var_4[var_5].going_to_object)) {
      continue;
    }
    if(isDefined(var_4[var_5].spawnpoint) && isDefined(var_4[var_5].spawnpoint.script_aigroup) && var_4[var_5].spawnpoint.script_aigroup == "_encstr_A9070A76C770C5EB1D01130B") {
      continue;
    }
    if(!istrue(var_4[var_5].entered_combat)) {
      continue;
    }
    if(var_4[var_5] scripts\cp\utility::isjuggernaut()) {
      continue;
    }
    if(isDefined(var_4[var_5].unittype) && var_4[var_5].unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
      continue;
    }
    if(istrue(var_4[var_5].playing_skit)) {
      continue;
    }
    if(var_4[var_5] scripts\cp\cp_modular_spawning::is_riding_vehicle()) {
      continue;
    }
    if(istrue(var_4[var_5].attempting_teleport)) {
      continue;
    }
    var_6 = undefined;

    if(isDefined(var_4[var_5].animationarchetype))
      var_6 = var_4[var_5].animationarchetype;
    else
      var_6 = var_4[var_5].asm.archetype;

    if(!isDefined(var_6)) {
      continue;
    }
    if(var_6 != "_encstr_958C08CDDBD8325A959C" && var_6 != "_encstr_ACF80B97CFB24530E51A66F982") {
      continue;
    }
    return var_4[var_5];
  }

  return undefined;
}

clear_custom_anim() {
  self allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_922406F1A6FD5E05", "_encstr_B13D076BED70539F23");
  scripts\asm\shared\mp\utility::bunkercounteruav();

  if(!istrue(self.dont_enter_combat))
    self.ignoreall = 0;

  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

alarm_fx_off(var_0) {
  var_1 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 setModel("_encstr_A7B92E9A6160638CE0319CAF237853A31D9902A1C94B5BC7201B8F8AAF60DDF3C5F3FBFBD0AFF3B19073BF65E1A97262");
  stopFXOnTag(level._effect["_encstr_B60912BA4A482A6AE1B1732F5BE11FBB999A42E3"], var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 stoploopsound();
  self.alarm_on = 0;
  self setHintString(&"_encstr_95B81887C91F49FBC6A43FC768A4F1A1E111AFC02F0F0C6109A5");
  var_0 notify("_encstr_8A490B1DAB279BAC91F5DE3333");
}

alarm_fx_on(var_0) {
  var_1 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 setModel("_encstr_B62031B128F9A97B2FB873283DC80B3ECCB7CDC91BE835E5CB5427B26E6FA0CCE3CB909D830A8B4FD89030CA59CFAA779F4590");
  playFXOnTag(level._effect["_encstr_B60912BA4A482A6AE1B1732F5BE11FBB999A42E3"], var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 playLoopSound("_encstr_B1160E5BD2B126856E56FA58360B935B");
  var_0 setHintString(&"_encstr_A554196882AF4DA2A452A515BC8A554A72EBE91991BE50260A29A6");
  var_0.alarm_on = 1;
  level notify("_encstr_91B909B0D858935BD77BE6");
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

run_to_and_plant_bomb(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0.planted = 0;
  self.going_to_object = var_0;
  var_1 = self.goalradius;
  run_to_bomb_location(self, var_0);
  plant_bomb(var_0);
  var_0.planted = 1;
  self.goalradius = var_1;
  self.going_to_object = undefined;
  clear_custom_anim();
}

run_to_bomb_location(var_0, var_1) {
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_915C0F88528AA7139349180D1FC3B8BBF6");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = var_1 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 = var_1 gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3);
  var_6.angles = getstartangles(var_4, var_5, var_3);
  var_6.animindex = var_2;
  var_6.xanim = var_3;
  var_0.ignoreall = 1;
  var_0 goto_anim_pos(var_6, 0);
}

plant_bomb(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("_encstr_A3B30E856CADE209A050075FE07EC3EF");
  var_1 scriptmodelplayanimdeltamotion("_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0");
  var_0.charge = var_1;
  thread _id_123B1(var_0, var_1);
  var_1 thread _id_13331();
  bleedout_logic("_encstr_915C0F88528AA7139349180D1FC3B8BBF6", var_0);
  self notify("_encstr_AB3D0DE25FE81EF7B7188A42230553");
}

_id_13331() {
  self endon("_encstr_AD75063D571AE108");
  self hide();
  wait 0.5;
  self show();
}

_id_123B1(var_0, var_1) {
  self endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_1))
    var_1 delete();
}

attract_agent_to_bomb_plant(var_0) {
  var_0 endon("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");

  for(;;) {
    var_1 = attract_an_agent(var_0, 1024);

    if(isDefined(var_1)) {
      var_1 run_to_and_plant_bomb(var_0);

      if(istrue(var_0.planted)) {
        var_0.attracting = 0;
        return;
      } else
        wait(randomintrange(5, 10));
    }

    wait 1;
  }
}

alarmbox2_logic(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.alarm_on = 0;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 makeunusable();
    var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_2, "_encstr_92130BA089B1A0B29E8F23EA62", 1);
    var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_9A280DCCAB37564CDB0FF51C39DEE0");

    if(!scripts\engine\utility::ent_flag("_encstr_85390A0F377AD5E89029E8C0")) {
      var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_AC010C3955ECA9038931DB187790", 1);
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_4], "_encstr_AC010C3955ECA9038931DB187790");
      scripts\engine\utility::ent_flag_set("_encstr_85390A0F377AD5E89029E8C0");
      var_0.alarm_on = 1;

      if(var_5 && istrue(var_1))
        alarm_fx_on(var_0);
    } else {
      var_4 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_8FF009022583A82537F313", 1);
      var_5 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_4], "_encstr_8FF009022583A82537F313");
      scripts\engine\utility::ent_flag_clear("_encstr_85390A0F377AD5E89029E8C0");
      var_0.alarm_on = 0;

      if(var_5 && istrue(var_1))
        alarm_fx_off(var_0);
    }

    var_0 makeusable();
    var_3 = undefined;
    var_4 = undefined;
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_92130BA089B1A0B29E8F23EA62"] = #animtree;
  level.scr_anim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = % _encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3;
  level.scr_animname["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = "_encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3";
  level.scr_eventanim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = "_encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3";
  level.scr_anim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D;
  level.scr_animname["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D";
  level.scr_eventanim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D";
  level.scr_animtree["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"] = #animtree;
  level.scr_anim["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_8FF009022583A82537F313"] = % _encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F;
  level.scr_animname["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_8FF009022583A82537F313"] = "_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F";
  level.scr_anim["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8;
  level.scr_animname["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8";
}

_id_142E2(var_0) {
  var_1 = ["_encstr_A5E52889A3B1F6C8238130493519793E8A1B61170FAB507847A2DB411AFFB0EDB397F787D7720421312A", "_encstr_B1E528193C7DB1076EEBDAC26B16BED8B0631BDBAE8EFAD6ED9C4716277D851D8EB06CDAD29BD9D79118", "_encstr_9AA32846E1D76C076E7D63856E37BED885C6D8BDEA3AFAD6ED4E3A5893BEC2E83AB0C66D5A379DAF8918", "_encstr_9BA32840833F31B96399718FEA1B9F79694B88A01FCC4E4B8AFA758782F12B43C4176808977E01778772"];
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, squared(512));
  var_3 = scripts\engine\utility::random(var_1);

  foreach(var_5 in var_2) {
    if(!isDefined(var_5._id_11E67))
      var_5._id_11E67 = gettime() + 30000;
    else if(gettime() < var_5._id_11E67) {
      continue;
    }
    var_5._id_11E67 = gettime() + 30000;
    thread scripts\cp\cp_vo::try_to_play_vo_for_one_player(var_3, var_5);
  }
}

_id_13A2B() {
  self.old_weapon = self.weapon;
  self.bunker_loot_vaults = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(self.bunker_loot_vaults);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.bunker_loot_vaults);
}

_id_12CC2() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.bunker_loot_vaults);
  self setspawnweapon(self.old_weapon);
}

_id_143CB(var_0, var_1) {
  while(distancesquared(self.origin, var_0) > var_1)
    wait 0.1;
}

haspackage(var_0) {
  var_0 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");
  clear_custom_anim();
  scripts\common\utility::clear_demeanor_override();

  if(isDefined(self._id_11E51))
    self.never_kill_off = self._id_11E51;

  if(isDefined(self.matchdata_logattackerkillevent))
    self.dont_kill_off = self.matchdata_logattackerkillevent;
}