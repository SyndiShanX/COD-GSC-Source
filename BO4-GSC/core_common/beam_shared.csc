/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\beam_shared.csc
***********************************************/

#include scripts\core_common\util_shared;

#namespace beam;

launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type, var_ee0708f0) {
  s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);

  if(!isDefined(s_beam)) {
    s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
  }

  if(self == level) {
    if(isDefined(level.localplayers)) {
      foreach(player in level.localplayers) {
        if(isDefined(player)) {
          beam_id = player launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);

          if(!(isDefined(var_ee0708f0) && var_ee0708f0)) {
            return beam_id;
          }
        }
      }
    }

    return;
  }

  if(isDefined(s_beam)) {
    s_beam.beam_id = beamlaunch(self.localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    self thread _kill_on_ent_death(self.localclientnum, s_beam, ent_1, ent_2);
    return s_beam.beam_id;
  }
}

function_cfb2f62a(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
  s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);

  if(!isDefined(s_beam)) {
    s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
  }

  if(isDefined(s_beam)) {
    s_beam.beam_id = beamlaunch(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    self thread _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2);
    return s_beam.beam_id;
  }

  return -1;
}

kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
  if(isDefined(self.active_beams)) {
    s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    arrayremovevalue(self.active_beams, s_beam, 0);
  }

  if(self == level) {
    if(isDefined(level.localplayers)) {
      foreach(player in level.localplayers) {
        if(isDefined(player)) {
          player kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
        }
      }
    }

    return;
  }

  if(isDefined(s_beam)) {
    s_beam notify(#"kill");
    beamkill(self.localclientnum, s_beam.beam_id);
  }
}

function_47deed80(localclientnum, beam_id) {
  if(isDefined(level.active_beams)) {
    s_beam = function_1c0feeb0(beam_id);
    arrayremovevalue(level.active_beams, s_beam, 0);
  }

  if(isDefined(s_beam)) {
    s_beam notify(#"kill");
    beamkill(localclientnum, s_beam.beam_id);
  }
}

private _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
  if(!isDefined(self.active_beams)) {
    self.active_beams = [];
  }

  s_beam = spawnStruct();
  s_beam.ent_1 = ent_1;
  s_beam.str_tag1 = str_tag1;
  s_beam.ent_2 = ent_2;
  s_beam.str_tag2 = str_tag2;
  s_beam.str_beam_type = str_beam_type;

  if(!isDefined(self.active_beams)) {
    self.active_beams = [];
  } else if(!isarray(self.active_beams)) {
    self.active_beams = array(self.active_beams);
  }

  self.active_beams[self.active_beams.size] = s_beam;
  return s_beam;
}

private _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
  if(isDefined(self.active_beams)) {
    foreach(s_beam in self.active_beams) {
      if(s_beam.ent_1 === ent_1 && s_beam.str_tag1 === str_tag1 && s_beam.ent_2 === ent_2 && s_beam.str_tag2 === str_tag2 && s_beam.str_beam_type === str_beam_type) {
        return s_beam;
      }
    }
  }
}

private function_1c0feeb0(beam_id) {
  if(isDefined(level.active_beams)) {
    foreach(s_beam in level.active_beams) {
      if(s_beam.beam_id === beam_id) {
        return s_beam;
      }
    }
  }
}

private _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2) {
  s_beam endon(#"kill");
  util::waittill_any_ents(ent_1, "death", ent_2, "death");

  if(isDefined(self)) {
    arrayremovevalue(self.active_beams, s_beam, 0);
    beamkill(localclientnum, s_beam.beam_id);
  }
}