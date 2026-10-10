/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2c0f726c7460dd7d.gsc
*************************************************/

#using script_5d813d45c6b1b1be;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_a461e274605f517e;

function init(var_5179c48492d1d2c2) {
  function_efabc5ae0422de9e(var_5179c48492d1d2c2, 1, undefined, "sitting");
  var_5179c48492d1d2c2.challenge_complete = 0;
  jump_struct = getStruct(var_5179c48492d1d2c2.target, "targetname");
  jump_trigger = function_698513ab21b7913d(jump_struct);
  var_5179c48492d1d2c2.jump_trigger = jump_trigger;
  pool_struct = getStruct(jump_struct.target, "targetname");
  pool_trigger = function_698513ab21b7913d(pool_struct);
  var_5179c48492d1d2c2.pool_trigger = pool_trigger;
  var_5179c48492d1d2c2.reward_struct = getStruct(pool_struct.target, "targetname");
  thread function_7997e8c2ef236551(var_5179c48492d1d2c2);
  thread function_d1db5a0838b22a18(var_5179c48492d1d2c2);
}

function private function_7997e8c2ef236551(var_5179c48492d1d2c2) {
  while(isDefined(var_5179c48492d1d2c2) && !istrue(var_5179c48492d1d2c2.challenge_complete)) {
    var_5179c48492d1d2c2.jump_trigger waittill("trigger", data);

    if(isPlayer(data) && !data isonground()) {
      if(!istrue(data.var_c9a127bae678ade5)) {
        iprintlnbold("<dev string:x1c>");

        data.var_c9a127bae678ade5 = 1;
        data.var_6453e34a7bfd9886 = 1;
        data thread function_6a4ceb59f0de0801();
      }
    }
  }
}

function private function_6a4ceb59f0de0801() {
  self endon("MRP_CANNONBALL_NOTIFY_SUCCESS");
  self endon("MRP_CANNONBALL_NOTIFY_FAIL");

  while(!self isonground()) {
    wait 0.1;
  }

  if(istrue(self.var_6453e34a7bfd9886)) {
    iprintlnbold("<dev string:x38>");

    self.var_c9a127bae678ade5 = undefined;
    self.var_6453e34a7bfd9886 = undefined;
    self notify("MRP_CANNONBALL_NOTIFY_FAIL");
  }
}

function private function_a3fb62f5dda0b5a() {
  self endon("MRP_CANNONBALL_NOTIFY_SUCCESS");
  self endon("MRP_CANNONBALL_NOTIFY_FAIL");
  self waittill("skydive_deployparachute");

  if(istrue(self.var_6453e34a7bfd9886)) {
    iprintlnbold("<dev string:x38>");

    self.var_c9a127bae678ade5 = undefined;
    self.var_6453e34a7bfd9886 = undefined;
    self notify("MRP_CANNONBALL_NOTIFY_FAIL");
  }
}

function private function_d1db5a0838b22a18(var_5179c48492d1d2c2) {
  var_5179c48492d1d2c2 endon("MRP_CANNONBALL_NOTIFY_SUCCESS");

  while(isDefined(var_5179c48492d1d2c2) && !istrue(var_5179c48492d1d2c2.challenge_complete)) {
    var_5179c48492d1d2c2.pool_trigger waittill("trigger", data);

    if(isPlayer(data) && data isswimming() && istrue(data.var_6453e34a7bfd9886)) {
      iprintlnbold("<dev string:x4d>");

      data.var_c9a127bae678ade5 = undefined;
      data.var_6453e34a7bfd9886 = undefined;
      var_5179c48492d1d2c2.challenge_complete = 1;
      var_5179c48492d1d2c2.jump_trigger delete();
      var_5179c48492d1d2c2.pool_trigger delete();
      thread function_82d05bedc3350817(data, var_5179c48492d1d2c2);
      data notify("MRP_CANNONBALL_NOTIFY_SUCCESS");
      var_5179c48492d1d2c2 notify("MRP_CANNONBALL_NOTIFY_SUCCESS");
    }
  }
}

function private function_82d05bedc3350817(player, var_5179c48492d1d2c2) {
  function_568b8a57e0fa955f(var_5179c48492d1d2c2, player);
  namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652(player, undefined, "ob_jup_items_activity_mrp_pool", 1);
}