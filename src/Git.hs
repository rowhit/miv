module Git
  ( clone
  , cloneSubmodule
  , pull
  , pullSubmodule
  , lastUpdate
  , gitStatus
  , gitUrl
  )
  where

import Data.Monoid ((<>))
import System.Exit (ExitCode(..))
import System.Process (system, readProcess)

clone :: String -> FilePath -> IO ExitCode
clone repo path = system $ unwords ["git", "clone", gitUrl repo, singleQuote path]

cloneSubmodule :: String -> FilePath -> IO ExitCode
cloneSubmodule repo path = system $ unwords ["git", "clone", gitUrl repo, singleQuote path, "&&", "&&", "git", "-C", singleQuote path, "submodule", "update", "--init", "--recursive"]

pull :: FilePath -> IO ExitCode
pull path = system $ unwords ["git", "-C", singleQuote path, "pull", "--rebase", "--prune"]

pullSubmodule :: FilePath -> IO ExitCode
pullSubmodule path = system $ unwords ["git", "-C", singleQuote path, "pull", "--rebase", "--prune", "&&", "git", "-C", singleQuote path, "submodule", "update", "--init", "--recursive"]

lastUpdate :: FilePath -> IO Integer
lastUpdate path = read <$> readProcess "sh" ["-c", unwords ["git", "-C", singleQuote path, "show", "-s", "--format=%ct", "2>/dev/null", "||", "echo", "0"]] []

gitStatus :: FilePath -> IO ExitCode
gitStatus path = system $ unwords ["git", "-C", singleQuote path, "status", ">/dev/null 2>&1"]

gitUrl :: String -> String
gitUrl = ("https://github.com/" <>)

singleQuote :: String -> String
singleQuote str = "'" <> str <> "'"
