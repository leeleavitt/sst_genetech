import sys
from typing import List
import defopt

from tools import sst_workflow


def main( argv : List[str] = sys.argv[1:]) -> None:
    defopt.run(funcs = [sst_workflow], argv=argv)