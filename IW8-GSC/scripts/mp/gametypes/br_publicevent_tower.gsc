/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_tower.gsc
*********************************************************/

function init() {
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_tower_weight", 0);
  var0.ref_140cf = &ref_140cf;
  var0.ref_14382 = &ref_14382;
  var0.attackerswaittime = &attackerswaittime;
  var0.isfeaturedisabled = &isfeaturedisabled;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_tower_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("tower", "20 20151510101010");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("tower");
  scripts\mp\gametypes\br_publicevents::ref_12b35(15, var0);
}

function postinitfunc() {
  game["dialog"]["boost_cyberattack_short"] = "boost_cyberattack_short";
}

function ref_140cf() {
  var0 = (21204, -13899, 4657);
  var1 = (18876, -16025, 4657);
  var2 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var0);
  var3 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var1);
  return var2 && var3;
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
  var0 = scripts\mp\gametypes\br_lootchopper::ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "heavy_weapon_crate", self.origin, (0, randomfloat(360), 0), var0);
    var1.ref_13428 = spawn("script_model", var0);
    var1.ref_13428 setModel("ks_airdrop_crate_br");
    var1.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
    var1.ref_135b6 = self.ref_135b6;

    if(isDefined(var1)) {
      thread ref_13451();
    }

    var2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var1);
    var2.ref_140a0 = 10;
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

function ref_12d23(var0) {
  switch (var0) {
    case "disarm_c4":
      var1 = "br_soa_tower_reward_disarm";
      var2 = scripts\mp\rank::getscoreinfovalue(var1);

      if(!isDefined(self)) {
        return;
      }

      thread scripts\mp\rank::giverankxp(var1, var2);
      thread scripts\mp\rank::scoreeventpopup(var1);
      break;
    case "c4_event_participant":
      var1 = "br_soa_tower_reward_helipad_complete";
      var2 = scripts\mp\rank::getscoreinfovalue(var1);

      if(!isDefined(self)) {
        return;
      }

      thread scripts\mp\rank::giverankxp(var1, var2);
      thread scripts\mp\rank::scoreeventpopup(var1);
      break;
  }
}