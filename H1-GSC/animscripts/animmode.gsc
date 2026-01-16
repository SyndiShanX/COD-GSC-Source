/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\animmode.gsc
********************************/

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self._tag_entity endon(self._anime);

  if(isdefined(self._custom_anim_thread)) {
    self thread[[self._custom_anim_thread]]();
    self._custom_anim_thread = undefined;
  }

  var_0 = isdefined(self._custom_anim_loop) && self._custom_anim_loop;

  if(var_0) {
    self endon("stop_loop");
    self._custom_anim_loop = undefined;
  } else
    thread notify_on_end(self._anime);

  var_1 = self._anime;
  self._anime = undefined;
  var_2 = 0;

  if(var_0 || isarray(level.scr_anim[self._animname][var_1])) {
    var_2 = level.scr_anim[self._animname][var_1].size;
    var_3 = level.scr_anim[self._animname][var_1][randomint(var_2)];
  } else
    var_3 = level.scr_anim[self._animname][var_1];

  var_4 = getstartorigin(self._tag_entity.origin, self._tag_entity.angles, var_3);
  var_5 = getstartangles(self._tag_entity.origin, self._tag_entity.angles, var_3);
  var_6 = self getdroptofloorposition(var_4);

  if(isdefined(var_6))
    var_4 = var_6;
  else {}

  if(!isdefined(self.noteleport))
    self teleport(var_4, var_5);

  self.pushable = 0;
  var_7 = 0.3;
  var_8 = 0.2;

  if(isdefined(self.anim_blend_time_override)) {
    var_7 = self.anim_blend_time_override;
    var_8 = self.anim_blend_time_override;
  }

  self animmode(self._animmode);
  self clearanim(self.root_anim, var_7);
  self orientmode("face angle", var_5[1]);
  var_9 = "custom_animmode";
  self setflaggedanimrestart(var_9, var_3, 1, var_8, 1);
  self._tag_entity thread maps\_anim::start_notetrack_wait(self, var_9, var_1, self._animname, var_3);
  self._tag_entity thread maps\_anim::animscriptdonotetracksthread(self, var_9, var_1);
  var_10 = self._tag_entity;
  self._tag_entity = undefined;
  self._animmode = undefined;
  self endon("killanimscript");
  var_11 = "end";

  if(!var_0) {
    if(animhasnotetrack(var_3, "finish"))
      var_11 = "finish";
    else if(animhasnotetrack(var_3, "stop anim"))
      var_11 = "stop anim";
  }

  for (;;) {
    self waittillmatch(var_9, var_11);

    if(var_0) {
      var_3 = level.scr_anim[self._animname][var_1][randomint(var_2)];
      self setflaggedanimknoblimitedrestart(var_9, var_3, 1, 0.2, 1);

      if(isdefined(var_10)) {
        var_10 thread maps\_anim::start_notetrack_wait(self, var_9, var_1, self._animname, var_3);
        var_10 thread maps\_anim::animscriptdonotetracksthread(self, var_9, var_1);
      }

      continue;
    }

    break;
  }

  if(var_11 != "end")
    self orientmode("face motion");

  self notify("finished_custom_animmode" + var_1);
}

notify_on_end(var_0) {
  self endon("death");
  self endon("finished_custom_animmode" + var_0);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + var_0);
}