# inotify event type
type Incron::Event = Enum[
  'IN_ALL_EVENTS',
  'IN_ACCESS',
  'IN_ATTRIB',
  'IN_CLOSE_WRITE',
  'IN_CLOSE_NOWRITE',
  'IN_CREATE',
  'IN_DELETE',
  'IN_DELETE_SELF',
  'IN_MODIFY',
  'IN_MOVE_SELF',
  'IN_MOVED_FROM',
  'IN_MOVED_TO',
  'IN_OPEN',

  'IN_DONT_FOLLOW',
  'IN_ONESHOT',
  'IN_ONLYDIR',

  'IN_NO_LOOP',
]
