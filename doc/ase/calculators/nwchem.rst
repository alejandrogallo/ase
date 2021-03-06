.. module:: ase.calculators.nwchem

======
NWChem
======

`NWChem <http://www.nwchem-sw.org>`_ is a computational chemistry code
based on gaussian basis functions or plane-waves.


Setup
=====

.. highlight:: bash

You first need to install a working copy of NWChem for ASE to call;
follow the instructions on the `NWChem website <http://www.nwchem-sw.org>`_.

The default command that ASE will use to start NWChem is
``nwchem PREFIX.nw > PREFIX.out``. You can change this command by setting the
environment variable :envvar:`ASE_NWCHEM_COMMAND`. (For example, add a line
to your ``.bashrc`` with ``export ASE_NWCHEM_COMMAND="my new command"``.)

The default command will only allow you to run NWChem on a single core. To
run on multiple processors you will need to specify your MPI (or similar)
command, which typically requires telling the MPI command the number of tasks
to dedicate to the process. An example command to allow multiprocessing is
``mpirun -n $SLURM_NTASKS nwchem PREFIX.nw > PREFIX.out``, for the SLURM
queueing system. If you use a different queueing system replace
``$SLURM_NTASKS`` with the appropriate variable, such as ``$PBS_NP``.


Examples
========

Here is a command line example of how to calculate optimize the geometry of a
water molecule using PBE::

    $ ase build H2O | ase run nwchem -p xc=PBE -f 0.02
    Running: H2O
    LBFGS:   0  09:58:54    -2064.914841       1.9673
    LBFGS:   1  09:58:55    -2064.976691       0.1723
    LBFGS:   2  09:58:55    -2064.977120       0.0642
    LBFGS:   3  09:58:55    -2064.977363       0.0495
    LBFGS:   4  09:58:56    -2064.977446       0.0233
    LBFGS:   5  09:58:56    -2064.977460       0.0059
    $ ase gui H2O.traj@-1 -tg "a(1,0,2),d(0,1)"
    102.591620591 1.00793234388

.. highlight:: python

An example of creating an NWChem calculator in the python interface is::

  from ase.calculators.nwchem import NWChem

  calc = NWChem(label='calc/nwchem',
                maxiter=2000,
                xc='B3LYP',
                basis='6-31+G*')


Parameters
==========

The list of possible parameters and their defaults is shown below.

=============== ======== ======================== ============================
keyword         type     default value            description
=============== ======== ======================== ============================
``label``       ``str``  ``'nwchem'``             Label for saved files.
``xc``          ``str``  ``'LDA'``                Exchange-correlation
                                                  functional.
``smearing``             ``None``                 Smearing.
``charge``               ``None``                 Charge
``task``        ``str``  ``'gradient'``           Task to perform. 'gradient'
                                                  means force call.
``geometry``    ``str``  ``'nocenter noautosym'`` Geometry arguments. Note
                                                  NWChem centers the
                                                  coordinates by default.
``convergence`` ``dict``                          Convergence criteria.
``basis``       ``str``  ``'3-21G'``              Basic set.
``basispar``             ``None``
``ecp``                  ``None``
``so``                   ``None``
``spinorbit``            ``None``
``odft``                 ``None``
``raw``                  ``''``                   Raw text outside DFT block
                                                  control string.
=============== ======== ======================== ============================

See the source code link below for further details.

.. autoclass:: NWChem
