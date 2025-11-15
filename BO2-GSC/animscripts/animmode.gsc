/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\animmode.gsc
**************************************/

#include maps\_anim;

main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self._tag_entity endon(self._scene);
  thread notify_on_end(self._scene);
  anime = self._scene;
  origin = getstartorigin(self._tag_entity.origin, self._tag_entity.angles, level.scr_anim[self._animname][self._scene]);
  angles = getstartangles(self._tag_entity.origin, self._tag_entity.angles, level.scr_anim[self._animname][self._scene]);
  origin = physicstrace(origin + vectorscale((0, 0, 1), 2.0), origin + vectorscale((0, 0, -1), 60.0));
  self teleport(origin, angles);
  self.pushable = 0;
  self animmode(self._animmode);
  self clearanim(self.root_anim, 0.3);
  self orientmode("face angle", angles[1]);
  anim_string = "custom_animmode";
  self setflaggedanimrestart(anim_string, level.scr_anim[self._animname][self._scene], 1, 0.2, 1);
  self._tag_entity thread maps\_anim::notetrack_wait(self, anim_string, self._scene, self._animname);
  self._tag_entity thread maps\_anim::animscriptdonotetracksthread(self, anim_string);
  self._tag_entity = undefined;
  anime = self._scene;
  self._scene = undefined;
  self._animmode = undefined;
  self endon("killanimscript");
  self waittillmatch(anim_string, "end");
  self notify("finished_custom_animmode" + anime);
}

notify_on_end(msg) {
  self endon("death");
  self endon("finished_custom_animmode" + msg);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + msg);
}