

from pymol import cmd
from glob import glob

def trajectory(filename, name="traj"):
    lst = glob(filename)
    for fil in lst: cmd.load(fil, name)

cmd.extend( 'trajectory', trajectory)