/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_595089f78ef8e11b.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_vox;

function function_afb445939fe4c1a4() {
  self.var_82420c8df7f30a5b = &function_e423d82a410af5dc;
}

function play_vox(ai, var_c2aec59361d95878, alias, priority) {
  ai endon("death");

  if(getdvarint(@ "hash_d01570d79c646246", 0) != 0) {
    return;
  }

  if(!isDefined(ai)) {
    return;
  }

  if(istrue(ai.var_c381a581e38c27e7)) {
    return;
  }

  if(isDefined(priority) && isDefined(self.var_32970d1295bb58af) && isDefined(ai.var_32970d1295bb58af[priority])) {
    if(gettime() < ai.var_32970d1295bb58af[priority]) {
      return;
    }
  }

  if(ai ent_flag("playing_vo") && isDefined(ai.var_7f11732708bb827d) && isDefined(priority)) {
    if(priority < ai.var_7f11732708bb827d || priority == 1) {
      return;
    }

    ai notify("ai_vo_override");

    if(ai isscriptable()) {
      ai setscriptablepartstate("sound_vo", "off");
    }

    if(priority > ai.var_7f11732708bb827d && !istrue(level.var_eb3b042962fb30a5)) {
      str_channel = ai function_fc041668d6654de8();
      ai stopsoundchannel(str_channel);
      level.var_eb3b042962fb30a5 = 1;
      waitframe();
      level.var_eb3b042962fb30a5 = 0;
    }

    waitframe();
  }

  if(soundexists(alias)) {
    ai.var_7f11732708bb827d = priority;
    ai ent_flag_set("playing_vo");
    time = lookupsoundlength(alias, 1);

    if(isDefined(var_c2aec59361d95878)) {
      assert(ai isscriptable());
      ai utility::function_3677f2be30fdd581("sound_vo", var_c2aec59361d95878);
    } else {
      ai playsoundonmovingent(alias);
    }

    ai endon("ai_vo_override");
    ai ent_flag_clear_delayed("playing_vo", function_c89ed1840c8d0f0f(time));

    if(ai isscriptable()) {
      ai setscriptablepartstate("sound_vo", "off");
    }

    ai.var_7f11732708bb827d = 0;
    return;
  }

  if(isDefined(var_c2aec59361d95878)) {
    ai utility::function_3677f2be30fdd581("sound_vo", var_c2aec59361d95878);
    return;
  }

  println("<dev string:x1c>" + alias);
}

function function_fc041668d6654de8() {
  if(self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "boss") {
    return "voice_zmb_elite_3d";
  }

  return "voice_zmb_1_3d";
}

function function_5420e83b135ec96f(time_ms, priority) {
  self.var_32970d1295bb58af = default_to(self.var_32970d1295bb58af, []);
  self.var_32970d1295bb58af[priority] = gettime() + time_ms;
}

function function_4922184552eb149() {
  self.var_c381a581e38c27e7 = default_to(self.var_c381a581e38c27e7, 0);
  self.var_c381a581e38c27e7 = 1;
}

function function_9c62fac1f9fdd26c() {
  self.var_c381a581e38c27e7 = default_to(self.var_c381a581e38c27e7, 0);
  self.var_c381a581e38c27e7 = 0;
}

function function_f11270bb42f7f080(notify_string, var_c2aec59361d95878, alias, priority) {
  level.var_a4adf98f94c5fd84 = default_to(level.var_a4adf98f94c5fd84, []);
  level.var_a4adf98f94c5fd84[self.basearchetype] = default_to(level.var_a4adf98f94c5fd84[self.basearchetype], []);
  state = spawnStruct();
  state.var_c2aec59361d95878 = var_c2aec59361d95878;
  state.priority = priority;
  state.alias = alias;
  level.var_a4adf98f94c5fd84[self.basearchetype][notify_string] = state;
}

function function_ea9336bca9113548(var_a8a2867722a244ed, notify_string, var_c2aec59361d95878, alias, priority) {
  level.var_a4adf98f94c5fd84 = default_to(level.var_a4adf98f94c5fd84, []);
  level.var_a4adf98f94c5fd84[self.basearchetype] = default_to(level.var_a4adf98f94c5fd84[self.basearchetype], []);
  state = spawnStruct();
  state.var_c2aec59361d95878 = var_c2aec59361d95878;
  state.priority = priority;
  state.alias = alias;
  level.var_a4adf98f94c5fd84[self.basearchetype][notify_string + var_a8a2867722a244ed] = state;
}

function private function_e423d82a410af5dc(state) {
  function_f707c26d8f269f94(state);
}

function function_f707c26d8f269f94(event) {
  if(!isDefined(self.basearchetype)) {
    return;
  }

  if(!isDefined(level.var_a4adf98f94c5fd84[self.basearchetype])) {
    return;
  }

  if(isDefined(self.subclass) && isDefined(level.var_a4adf98f94c5fd84[self.basearchetype][event + self.subclass])) {
    event += self.subclass;
  }

  var_42db284ef44b45b = level.var_a4adf98f94c5fd84[self.basearchetype][event];

  if(!isDefined(var_42db284ef44b45b)) {
    return;
  }

  var_c2aec59361d95878 = var_42db284ef44b45b.var_c2aec59361d95878;
  alias = var_42db284ef44b45b.alias;
  priority = var_42db284ef44b45b.priority;

  if(isDefined(self.var_74e2482f0c021e12)) {
    level thread[[self.var_74e2482f0c021e12]](event, self, var_c2aec59361d95878, alias, priority);
    return;
  }

  level thread play_vox(self, var_c2aec59361d95878, alias, priority);
}

function function_3b76e1d247d2f5a(var_74e2482f0c021e12) {
  self.var_74e2482f0c021e12 = var_74e2482f0c021e12;
}