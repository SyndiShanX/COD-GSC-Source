/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6be10b56f79771f3.gsc
*************************************************/

#using script_315e06108d117c9a;
#using script_3ed005fe9b78b9da;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\teams;
#namespace namespace_c28d5b1888f4e14;

function main() {
  registersharedfunc("limbo", "limbo_become_mutant", &limbo_become_mutant);
  level thread initpostmain();
  level callback::add("player_death", &onplayerdeath);
  level callback::add("player_spawned", &onplayerspawned);
}

function initpostmain() {
  waittillframeend();
  namespace_579c1620477fc1a::initpostmain();
}

function onplayerspawned(data) {
  function_746e21faa11f4397();
  val::reset("limbo_mutant", "killstreaks");
}

function onplayerdeath(data) {
  function_76ae8c199e0cdf45();
}

function function_76ae8c199e0cdf45() {
  if(isDefined(self.var_e5520effcbe8bd30)) {
    self.class = self.var_cb14b76a2a24fe70;
    function_43670a5894805453(self.var_bb02c51d337e2e5, self.var_8113f7d87217bbb3);
    namespace_62dabdb9dfdcde8::function_702b1da0c13a5636();
    self clearsoundsubmix("jup_mp_mutation_breath", 1);
    self clearsoundsubmix("jup_mp_mutation_hellhound_radioactive_beast", 1);
    self setscriptablepartstate("mutant_cloak", "inactive");
    self.var_e5520effcbe8bd30 = undefined;
    val::reset("limbo_mutant", "killstreaks");
  }
}

function function_43670a5894805453(body, head) {
  player = self;
  player setcustomization(body, head);
  bodymodelname = player getcustomizationbody();
  headmodelname = player getcustomizationhead();
  viewmodelname = player getcustomizationviewmodel();
  player scripts\mp\teams::setcharactermodels(body, head, viewmodelname);
}

function limbo_become_mutant(var_6b01b408b9c1b4b6) {
  if(isDefined(self.var_e5520effcbe8bd30)) {
    return;
  }

  if(var_6b01b408b9c1b4b6 == "mutant_sneaker_br") {
    self.var_e5520effcbe8bd30 = "sneaker";
  }

  val::set("limbo_mutant", "killstreaks", 0);
  self.var_471ed63d0b3754db = scripts\mp\class::loadout_getclassstruct();
  self.var_cb14b76a2a24fe70 = self.class;
  self.var_8113f7d87217bbb3 = self.operatorcustomization.head;
  self.var_bb02c51d337e2e5 = self.operatorcustomization.body;
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "none";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryAttachment3"] = "none";
  loadout["loadoutPrimaryAttachment4"] = "none";
  loadout["loadoutPrimaryAttachment5"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryAttachment3"] = "none";
  loadout["loadoutSecondaryAttachment4"] = "none";
  loadout["loadoutSecondaryAttachment5"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutSwimWeapon"] = "none";
  loadout["loadoutClimbWeapon"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "none";
  loadout["loadoutGesture"] = "playerData";
  self.pers["gamemodeLoadout"] = loadout;
  self.class = "gamemode";
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  scripts\mp\class::giveloadout(self.team, "gamemode", 1, 1);

  if(var_6b01b408b9c1b4b6 == "mutant_sneaker_br") {
    if(isDefined(self.classstruct.var_91e10e152b08ec1d)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.classstruct.var_91e10e152b08ec1d);
    }

    namespace_62dabdb9dfdcde8::function_852acf50e7345bc8();
  }

  function_90a8ed71e24e192a();
  level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("limbo_becomeMutant", self, 1, 0);
}

function function_d204f8977e5c0697() {
  return isDefined(self.var_e5520effcbe8bd30);
}

function function_90a8ed71e24e192a() {
  self setclientomnvar("ui_only_default_loadouts_player", 1);
  self setclientomnvar("ui_mutation_zombie_type", 1);
}

function function_746e21faa11f4397() {
  self setclientomnvar("ui_only_default_loadouts_player", 0);
}