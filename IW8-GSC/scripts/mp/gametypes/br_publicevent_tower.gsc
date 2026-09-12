/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_tower.gsc
*********************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_tower_weight", 0);
  var_0.ref_140cf = &ref_140cf;
  var_0.ref_14382 = &ref_14382;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.isfeaturedisabled = &isfeaturedisabled;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11b78 = getdvarint("scr_br_pe_tower_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("tower", "20 20151510101010");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("tower");
  scripts\mp\gametypes\br_publicevents::ref_12b35(15, var_0);
}

function postinitfunc() {
  game["dialog"]["boost_cyberattack_short"] = "boost_cyberattack_short";
}

function ref_140cf() {
  var_0 = (21204, -13899, 4657);
  var_1 = (18876, -16025, 4657);
  var_2 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_0);
  var_3 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_1);
  return var_2 && var_3;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
}

function attackerswaittime() {
  level endon("game_ended");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_tower_start");
  scripts\mp\gametypes\br_public::brleaderdialog("boost_cyberattack_short", 1);
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  scripts\mp\gametypes\br_event_soa_tower_helipad::init();
}

function isfeaturedisabled() {}

function ref_1344e() {
  var_0 = scripts\mp\gametypes\br_lootchopper::ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "heavy_weapon_crate", self.origin, (0, randomfloat(360), 0), var_0);
    var_1.ref_13428 = spawn("script_model", var_0);
    var_1.ref_13428 setModel("ks_airdrop_crate_br");
    var_1.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
    var_1.ref_135b6 = self.ref_135b6;

    if(isDefined(var_1)) {
      thread ref_13451();
    }

    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2.ref_140a0 = 10;
    return;
  }
}

function ref_13451() {
  self setscriptablepartstate("objective", "heavy_weapon_public");
}

function connectedplayercount() {
  self.stadiumpuzzleactive = 1;
  self waittill("near_goal");
  self.stadiumpuzzleactive = 0;
}

function ref_12d23(var_0) {
  switch (var_0) {
    case "disarm_c4":
      var_1 = "br_soa_tower_reward_disarm";
      var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

      if(!isDefined(self)) {
        return;
      }

      thread scripts\mp\rank::giverankxp(var_1, var_2);
      thread scripts\mp\rank::scoreeventpopup(var_1);
      break;
    case "c4_event_participant":
      var_1 = "br_soa_tower_reward_helipad_complete";
      var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

      if(!isDefined(self)) {
        return;
      }

      thread scripts\mp\rank::giverankxp(var_1, var_2);
      thread scripts\mp\rank::scoreeventpopup(var_1);
      break;
  }
}