import os, sys
histfile_ = os.path.join(os.path.expanduser("~"), ".python_history")
try:
    import readline
    if not os.path.exists(histfile_):
        open(histfile_, 'w').close()
    readline.read_history_file(histfile_)
except StandardError:
    pass  # raise
else:
    import rlcompleter
    if sys.platform == 'darwin':
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind('tab: complete')
    import atexit
    atexit.register(readline.write_history_file, histfile_)
    del atexit, readline, rlcompleter

del histfile_
# vim: set ts=4 sw=4 et:
