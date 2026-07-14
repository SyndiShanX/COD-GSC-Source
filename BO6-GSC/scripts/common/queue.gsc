/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\queue.gsc
**************************************/

#using scripts\engine\utility;
#namespace queue;

function function_7ca00dfc6f1da53c(queue, ref, init_func, break_func, interrupt_func, finish_func, func_params, priority, duration, break_notify) {
  item = spawnStruct();
  item.ref = ref ?? "\x91\xca\xcc\v\xab\xd8:";
  item.init_func = init_func;
  item.break_func = break_func;
  item.interrupt_func = interrupt_func;
  item.finish_func = finish_func;
  item.func_params = func_params;
  item.priority = priority ?? 0;
  item.duration = duration;
  item.break_notify = break_notify;
  function_e964ae838fe2a244(queue, item);
}

function function_e964ae838fe2a244(queue, item) {
  if(!isDefined(self.priority_queues)) {
    self.priority_queues = [];
  }

  if(!isDefined(self.priority_queues[queue])) {
    self.priority_queues[queue] = spawnStruct();
  }

  if(!isDefined(item.ref)) {
    item.ref = "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!isDefined(item.priority)) {
    item.priority = 0;
  }

  if(!isDefined(self.priority_queues[queue].items) || self.priority_queues[queue].items.size == 0) {
    self.priority_queues[queue].items = [];
    self.priority_queues[queue].items[0] = item;
    thread function_cec6a9035973173a(queue);
    return;
  }

  index = self.priority_queues[queue].items.size;
  ref_updated = 0;

  foreach(idx, data in self.priority_queues[queue].items) {
    if(item.ref != "\x91\xca\xcc\v\xab\xd8:" && item.ref == data.ref) {
      if(idx == 0) {
        assert("<dev string:x24>" + item.ref + "<dev string:x31>" + queue + "<dev string:x3f>");
        return;
      }

      self.priority_queues[queue].items[idx] = item;
      ref_updated = 1;
      break;
    }

    if(!isDefined(index) && item.priority > data.priority) {
      index = idx;
    }
  }

  if(!ref_updated && isDefined(index)) {
    self.priority_queues[queue].items = utility::array_insert(self.priority_queues[queue].items, item, index);

    if(index == 0) {
      thread function_3f9bea11a9ea10c(queue, self.priority_queues[queue].items[1]);
    }
  }
}

function function_b2f64b3dc229d203(queue, ref) {
  if(isDefined(self.priority_queues) && isDefined(self.priority_queues[queue])) {
    for(i = self.priority_queues[queue].items.size - 1; i >= 0; i--) {
      if(self.priority_queues[queue].items[i].ref == ref) {
        self.priority_queues[queue].items = utility::array_remove_index(self.priority_queues[queue].items, i);

        if(i == 0) {
          self notify(queue + "r\x14\xb7\xacwz\xb3?");
        }
      }
    }
  }
}

function function_2b471d357d039cf2(queue) {
  if(isDefined(self.priority_queues) && isDefined(self.priority_queues[queue])) {
    if(self.priority_queues[queue].items.size > 0) {
      self notify(queue + "r\x14\xb7\xacwz\xb3?");
    }

    self.priority_queues[queue] = undefined;
  }
}

function private function_cec6a9035973173a(queue) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(isDefined(self.priority_queues[queue]) && self.priority_queues[queue].items.size > 0) {
    item = self.priority_queues[queue].items[0];
    item.start_time = gettime();

    if(isDefined(item.break_func) && self[[item.break_func]](item.func_params, item.start_time, 1)) {
      self.priority_queues[queue].items = utility::array_remove_index(self.priority_queues[queue].items, 0);
      continue;
    }

    if(isDefined(item.init_func)) {
      self thread[[item.init_func]](item.func_params, item.start_time, [queue + "r\x14\xb7\xacwz\xb3?", queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19", queue + "\xfa\x91o\x9be"]);
    }

    if(isDefined(item.break_func)) {
      childthread function_dee924934ca83590(queue, item);
    }

    ret = undefined;

    if(isDefined(item.duration)) {
      if(isDefined(item.break_notify)) {
        ret = utility::waittill_any_timeout(item.duration, item.break_notify, queue + "\xa0\xe7Gy\xb9\xc4", queue + "r\x14\xb7\xacwz\xb3?", queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19");
      } else {
        ret = utility::waittill_any_timeout(item.duration, queue + "\xa0\xe7Gy\xb9\xc4", queue + "r\x14\xb7\xacwz\xb3?", queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19");
      }
    } else {
      ret = utility::waittill_any_return(queue + "\xa0\xe7Gy\xb9\xc4", queue + "r\x14\xb7\xacwz\xb3?", queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19", item.break_notify);
    }

    if(ret == "\xb5B\xd7\x904}\x11" || ret == queue + "\xa0\xe7Gy\xb9\xc4" || isDefined(item.break_notify) && ret == item.break_notify) {
      function_558acfb774cfe98(queue, item);
      continue;
    }

    if(ret == queue + "r\x14\xb7\xacwz\xb3?") {
      function_3f9bea11a9ea10c(queue, item);
    }
  }
}

function private function_dee924934ca83590(queue, item) {
  self endon(queue + "\xfa\x91o\x9be");
  self endon(queue + "r\x14\xb7\xacwz\xb3?");
  self endon(queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19");

  while(!self[[item.break_func]](item.func_params, item.start_time)) {
    waitframe();
  }

  self notify(queue + "\xa0\xe7Gy\xb9\xc4");
}

function private function_3f9bea11a9ea10c(queue, item) {
  if(isDefined(item.interrupt_func)) {
    self thread[[item.interrupt_func]](item.func_params, item.start_time);
  }

  self notify(queue + "\x0f2\xc8\x9c\xb0W, \x03\xed\x17\x19");
}

function private function_558acfb774cfe98(queue, item) {
  if(isDefined(item.finish_func)) {
    self thread[[item.finish_func]](item.func_params, item.start_time);
  }

  self notify(queue + "\xfa\x91o\x9be");
  self.priority_queues[queue].items = utility::array_remove_index(self.priority_queues[queue].items, 0);
}