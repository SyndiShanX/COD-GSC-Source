/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_bb_recovery.gsc
*********************************************************/

main(var_0) {
  level.obj_bb_recovery = ::register_objective;
}

blank(var_0) {}

register_objective() {
  scripts\cp\cp_objectives::registerobjective("_encstr_A1F9123D6E37C069C9E33187DB4B1B6A8EE17AD3", ::blank, ::bb_recovery, ::blank, ::blank, ::blank);
}

bb_recovery(var_0) {
  level endon("_encstr_96C80D8BDDA02ADB91A5E6EA925F9F");
  objective_position(var_0.objectiveindex, level.current_blackbox_corpse.origin + (0, 0, 100));
  level thread bb_timer();
  level waittill("_encstr_B63D0B5EF69981480DCF28E093");
  level.current_blackbox = undefined;
  level.current_blackbox_corpse = undefined;
  scripts\cp\cp_objectives::lua_objective_incomplete("_encstr_A1F9123D6E37C069C9E33187DB4B1B6A8EE17AD3");
}

start_bb_recovery(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, -136));
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_AAB020634BD75F99C33D81391F6D60296F12D8AB21471B0851128193455609E577DB");
  var_0 delete();
  var_1 setscriptablepartstate("_encstr_878807108A42A309BB", "_encstr_AB0703DBB9");
  var_1 setscriptablepartstate("_encstr_8A6D07B9E816CE9566", "_encstr_AB0703DBB9");
  var_2 = randomint(360);
  var_3 = randomintrange(150, 500);
  var_4 = var_1.origin + anglesToForward((0, var_2, 0)) * var_3;
  var_5 = getgroundposition(getclosestpointonnavmesh(var_4), 24) + (0, 0, 3);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_6 setModel("_encstr_811626E7519BB3B325D0D3BB4198E8A3500B47B20B89C2A9C163E5F977CA5C9767631921D24B149B");
  var_6.angles = (-90, 0, 0);
  var_1.script_noteworthy = "_encstr_868B0930934171CF32D53B";
  level.current_blackbox = var_6;
  level.current_blackbox_corpse = var_1;
  level.current_blackbox playLoopSound("_encstr_A56018E68D73D7C607F526C685C65B4CBD0FFA13AC9583BED8E0");

  if(getdvarint("_encstr_8DA50EB986B7BBF5C4C6B0C6ADC4B70F") > 0)
    var_6 hudoutlineenable("_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40");

  level thread recover_bb(level.current_blackbox);
  thread scripts\cp\cp_objectives::run_objective("_encstr_A1F9123D6E37C069C9E33187DB4B1B6A8EE17AD3");
}

bb_timer() {
  var_0 = level.current_blackbox_corpse.origin;
  wait 90;
  level notify("_encstr_B63D0B5EF69981480DCF28E093");
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0);
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  wait 0.15;
  level.current_blackbox_corpse delete();

  if(isDefined(level.current_blackbox))
    level.current_blackbox stoploopsound();

  waitframe();

  if(isDefined(level.current_blackbox))
    level.current_blackbox delete();

  earthquake(0.45, 3, var_0, 1024);
  radiusdamage(var_0 + (0, 0, 50), 1024, 500, 50);
}

recover_bb(var_0) {
  var_0 makeusable();
  var_0 setHintString(&"_encstr_920A185327E64713A5B140B89A499CFB3F08CACDD68C1B2FA381");
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(96);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_0 thread bb_think();
}

bb_think() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    scripts\cp\cp_objectives::lua_objective_complete("_encstr_A1F9123D6E37C069C9E33187DB4B1B6A8EE17AD3");
    level notify("_encstr_96C80D8BDDA02ADB91A5E6EA925F9F");
    level.current_blackbox stoploopsound();
    var_0 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_95D01968057DD48A9494A5549794A21AE94A882A4AFA913D557288", "_encstr_9A8507BA4040188D08", 5);
    waitframe();
    self delete();
    return;
  }
}