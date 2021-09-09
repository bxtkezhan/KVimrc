# This file is NOT licensed under the GPLv3, which is the license for the rest
# of YouCompleteMe.
#
# Here's the license text for this file:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

from distutils.sysconfig import get_python_inc
import platform
import os.path as p
import subprocess

DIR_OF_THIS_SCRIPT = p.abspath( p.dirname( __file__ ) )
DIR_OF_THIRD_PARTY = p.join( DIR_OF_THIS_SCRIPT, 'third_party' )
DIR_OF_WATCHDOG_DEPS = p.join( DIR_OF_THIRD_PARTY, 'watchdog_deps' )
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

database = None

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-Wall',
'-Wextra',
'-Werror',
'-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-DNDEBUG',
# You 100% do NOT need -DUSE_CLANG_COMPLETER and/or -DYCM_EXPORT in your flags;
# only the YCM source code needs it.
'-DUSE_CLANG_COMPLETER',
'-DYCM_EXPORT=',
'-DYCM_ABSEIL_SUPPORTED',
# THIS IS IMPORTANT! Without the '-x' flag, Clang won't know which language to
# use when compiling headers. So it will guess. Badly. So C++ headers will be
# compiled as C headers. You don't want that so ALWAYS specify the '-x' flag.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'-isystem',
'cpp/absl',
'-isystem',
'cpp/pybind11',
'-isystem',
'cpp/whereami',
'-isystem',
'cpp/BoostParts',
'-isystem',
get_python_inc(),
'-isystem',
'cpp/llvm/include',
'-isystem',
'cpp/llvm/tools/clang/include',
'-I',
'cpp/ycm',
'-I',
'cpp/ycm/ClangCompleter',
'-isystem',
'cpp/ycm/tests/gmock/googlemock/include',
'-isystem',
'cpp/ycm/tests/gmock/googletest/include',
'-isystem',
'cpp/ycm/benchmarks/benchmark/include',
'-std=c++17',
]

# Extend by kk
flags.extend([
'-I',
'/usr/include/eigen3',
'-I',
'/usr/include/x86_64-linux-gnu/qt5',
'-I',
'/usr/include/llvm-10',
'-I',
'/usr/include/llvm-c-10',
'-I',
'/usr/include/gtk-3.0',
'-I',
'/usr/include/glib-2.0',
'-I',
'/usr/lib/x86_64-linux-gnu/glib-2.0/include',
'-I',
'/usr/include/pango-1.0',
'-I',
'/usr/include/harfbuzz',
'-I',
'/usr/include/cairo',
'-I',
'/usr/include/gdk-pixbuf-2.0',
'-I',
'/usr/include/atk-1.0',
'-I',
'/usr/include/gtkmm-3.0',
'-I',
'/usr/lib/x86_64-linux-gnu/gtkmm-3.0/include',
'-I',
'/usr/include/glibmm-2.4',
'-I',
'/usr/lib/x86_64-linux-gnu/glibmm-2.4/include',
'-I',
'/usr/include/sigc++-2.0',
'-I',
'/usr/lib/x86_64-linux-gnu/sigc++-2.0/include',
'-I',
'/usr/include/giomm-2.4',
'-I',
'/usr/lib/x86_64-linux-gnu/giomm-2.4/include',
'-I',
'/usr/include/gdkmm-3.0',
'-I',
'/usr/lib/x86_64-linux-gnu/gdkmm-3.0/include',
'-I',
'/usr/include/pangomm-1.4',
'-I',
'/usr/lib/x86_64-linux-gnu/pangomm-1.4/include',
'-I',
'/usr/include/cairomm-1.0',
'-I',
'/usr/lib/x86_64-linux-gnu/cairomm-1.0/include',
'-I',
'/usr/include/freetype2',
'-I',
'/usr/include/atkmm-1.6',
'-I',
'/usr/include/webkitgtk-4.0',
'-I',
'/usr/include/gtksourceview-3.0',
'-I',
'/usr/include/libsoup-2.4',
'-I',
'/usr/lib/gcc/x86_64-linux-gnu/9/include',
])

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# You can get CMake to generate this file for you by adding:
#   set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
# to your CMakeLists.txt file.
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''


def IsHeaderFile( filename ):
  extension = p.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def FindCorrespondingSourceFile( filename ):
  if IsHeaderFile( filename ):
    basename = p.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if p.exists( replacement_file ):
        return replacement_file
  return filename


def PathToPythonUsedDuringBuild():
  try:
    filepath = p.join( DIR_OF_THIS_SCRIPT, 'PYTHON_USED_DURING_BUILDING' )
    with open( filepath ) as f:
      return f.read().strip()
  except OSError:
    return None


def Settings( **kwargs ):
  # Do NOT import ycm_core at module scope.
  import ycm_core

  global database
  if database is None and p.exists( compilation_database_folder ):
    database = ycm_core.CompilationDatabase( compilation_database_folder )

  language = kwargs[ 'language' ]

  if language == 'cfamily':
    # If the file is a header, try to find the corresponding source file and
    # retrieve its flags from the compilation database if using one. This is
    # necessary since compilation databases don't have entries for header files.
    # In addition, use this source file as the translation unit. This makes it
    # possible to jump from a declaration in the header file to its definition
    # in the corresponding source file.
    filename = FindCorrespondingSourceFile( kwargs[ 'filename' ] )

    if not database:
      return {
        'flags': flags,
        'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT,
        'override_filename': filename
      }

    compilation_info = database.GetCompilationInfoForFile( filename )
    if not compilation_info.compiler_flags_:
      return {}

    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object.
    final_flags = list( compilation_info.compiler_flags_ )

    # NOTE: This is just for YouCompleteMe; it's highly likely that your project
    # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    # ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
    try:
      final_flags.remove( '-stdlib=libc++' )
    except ValueError:
      pass

    return {
      'flags': final_flags,
      'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
      'override_filename': filename
    }

  if language == 'python':
    return {
      # Extend by kk
      # 'interpreter_path': PathToPythonUsedDuringBuild()
      'interpreter_path': subprocess.check_output(
        ['python3', '-c', 'import sys;print(sys.executable)']).decode().strip()
    }

  return {}


def PythonSysPath( **kwargs ):
  sys_path = kwargs[ 'sys_path' ]

  interpreter_path = kwargs[ 'interpreter_path' ]
  major_version = subprocess.check_output( [
    interpreter_path, '-c', 'import sys; print( sys.version_info[ 0 ] )' ]
  ).rstrip().decode( 'utf8' )

  sys_path[ 0:0 ] = [ p.join( DIR_OF_THIS_SCRIPT ),
                      p.join( DIR_OF_THIRD_PARTY, 'bottle' ),
                      p.join( DIR_OF_THIRD_PARTY, 'regex-build' ),
                      p.join( DIR_OF_THIRD_PARTY, 'frozendict' ),
                      p.join( DIR_OF_THIRD_PARTY, 'jedi_deps', 'jedi' ),
                      p.join( DIR_OF_THIRD_PARTY, 'jedi_deps', 'parso' ),
                      p.join( DIR_OF_WATCHDOG_DEPS, 'watchdog', 'build', 'lib3' ),
                      p.join( DIR_OF_WATCHDOG_DEPS, 'pathtools' ),
                      p.join( DIR_OF_THIRD_PARTY, 'waitress' ) ]

  sys_path.append( p.join( DIR_OF_THIRD_PARTY, 'jedi_deps', 'numpydoc' ) )
  return sys_path
