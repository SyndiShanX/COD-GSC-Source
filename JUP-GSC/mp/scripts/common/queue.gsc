/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\queue.gsc
***********************************************/

#using scripts\engine\utility;
#namespace queue;

function function_e6d5d1b10a962759(queue, ref, init_func, break_func, interrupt_func, finish_func, func_params, priority, duration, break_notify) {
  item = spawnStruct();
  item.ref = default_to(ref, "default");
  item.init_func = init_func;
  item.break_func = break_func;
  item.interrupt_func = interrupt_func;
  item.finish_func = finish_func;
  item.func_params = func_params;
  item.priority = default_to(priority, 0);
  item.duration = duration;
  item.break_notify = break_notify;
  function_ffbf82197897dac9(queue, item);
}

function function_ffbf82197897dac9(queue, item) {
  if(!isDefined(self.var_fd776bf3ffd9d44e)) {
    self.var_fd776bf3ffd9d44e = [];
  }

  if(!isDefined(self.var_fd776bf3ffd9d44e[queue])) {
    self.var_fd776bf3ffd9d44e[queue] = spawnStruct();
  }

  item.ref = default_to(item.ref, "default");
  item.priority = default_to(item.priority, 0);

  if(!isDefined(self.var_fd776bf3ffd9d44e[queue].items) || self.var_fd776bf3ffd9d44e[queue].items.size == 0) {
    self.var_fd776bf3ffd9d44e[queue].items = [];
    self.var_fd776bf3ffd9d44e[queue].items[0] = item;
    thread function_a21a0cb1935daf63(queue);
    return;
  }

  index = self.var_fd776bf3ffd9d44e[queue].items.size;
  ref_updated = 0;

  foreach(idx, data in self.var_fd776bf3ffd9d44e[queue].items) {
    if(item.ref != "default" && item.ref == data.ref) {
      if(idx == 0) {
        assert("<dev string:x1c>" + item.ref + "<dev string:x29>" + queue + "<dev string:x37>");
        return;
      }

      self.var_fd776bf3ffd9d44e[queue].items[idx] = item;
      ref_updated = 1;
      break;
    }

    if(!isDefined(index) && item.priority > data.priority) {
      index = idx;
    }
  }

  if(!ref_updated && isDefined(index)) {
    self.var_fd776bf3ffd9d44e[queue].items = array_insert(self.var_fd776bf3ffd9d44e[queue].items, item, index);

    if(index == 0) {
      thread function_b4f70eec2b62bbc5(queue, self.var_fd776bf3ffd9d44e[queue].items[1]);
    }
  }
}

function function_46d80f020560ce6(queue, ref) {
  if(isDefined(self.var_fd776bf3ffd9d44e) && isDefined(self.var_fd776bf3ffd9d44e[queue])) {
    for(i = self.var_fd776bf3ffd9d44e[queue].items.size - 1; i >= 0; i--) {
      if(self.var_fd776bf3ffd9d44e[queue].items[i].ref == ref) {
        self.var_fd776bf3ffd9d44e[queue].items = array_remove_index(self.var_fd776bf3ffd9d44e[queue].items, i);

        if(i == 0) {
          self notify(queue + "_removed");
        }
      }
    }
  }
}

function function_5bf3778b0956a0ab(queue) {
  if(isDefined(self.var_fd776bf3ffd9d44e) && isDefined(self.var_fd776bf3ffd9d44e[queue])) {
    if(self.var_fd776bf3ffd9d44e[queue].items.size > 0) {
      self notify(queue + "_removed");
    }

    self.var_fd776bf3ffd9d44e[queue] = undefined;
  }
}

function private function_a21a0cb1935daf63(queue) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(self.var_fd776bf3ffd9d44e[queue]) && self.var_fd776bf3ffd9d44e[queue].items.size > 0) {
    item = self.var_fd776bf3ffd9d44e[queue].items[0];
    item.start_time = gettime();

    if(isDefined(item.break_func) && self[[item.break_func]](item.func_params, item.start_time, 1)) {
      self.var_fd776bf3ffd9d44e[queue].items = array_remove_index(self.var_fd776bf3ffd9d44e[queue].items, 0);
      continue;
    }

    if(isDefined(item.init_func)) {
      self thread[[item.init_func]](item.func_params, item.start_time, [queue + "_removed", queue + "_interrupted", queue + "_done"]);
    }

    if(isDefined(item.break_func)) {
      childthread function_83c2eeef11738a5d(queue, item);
    }

    ret = undefined;

    if(isDefined(item.duration)) {
      if(isDefined(item.break_notify)) {
        ret = waittill_any_timeout_4(item.duration, item.break_notify, queue + "_break", queue + "_removed", queue + "_interrupted");
      } else {
        ret = waittill_any_timeout_3(item.duration, queue + "_break", queue + "_removed", queue + "_interrupted");
      }
    } else if(isDefined(item.break_notify)) {
      ret = waittill_any_return_4(item.break_notify, queue + "_break", queue + "_removed", queue + "_interrupted");
    } else {
      ret = waittill_any_return_3(queue + "_break", queue + "_removed", queue + "_interrupted");
    }

    if(ret == "timeout" || ret == queue + "_break" || isDefined(item.break_notify) && ret == item.break_notify) {
      function_e4f3902eebc8816d(queue, item);
      continue;
    }

    if(ret == queue + "_removed") {
      function_b4f70eec2b62bbc5(queue, item);
    }
  }
}

function private function_83c2eeef11738a5d(queue, item) {
  self endon(queue + "_done");
  self endon(queue + "_removed");
  self endon(queue + "_interrupted");

  while(!self[[item.break_func]](item.func_params, item.start_time)) {
    waitframe();
  }

  self notify(queue + "_break");
}

function private function_b4f70eec2b62bbc5(queue, item) {
  if(isDefined(item.interrupt_func)) {
    self thread[[item.interrupt_func]](item.func_params, item.start_time);
  }

  self notify(queue + "_interrupted");
}

function private function_e4f3902eebc8816d(queue, item) {
  if(isDefined(item.finish_func)) {
    self thread[[item.finish_func]](item.func_params, item.start_time);
  }

  self notify(queue + "_done");
  self.var_fd776bf3ffd9d44e[queue].items = array_remove_index(self.var_fd776bf3ffd9d44e[queue].items, 0);
}