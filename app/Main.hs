module Main where

import Data.Map.Strict (Map, (!))
import Data.Text.IO qualified as T
import Hledger.Cli.Script
  ( AccountName,
    AccountType (Expense, Revenue),
    Posting,
    Transaction,
    defcliopts,
    exitFailure,
    forM_,
    jaccounttypes,
    jtxns,
    paccount,
    pamount,
    showTransaction,
    tpostings,
    when,
    withJournalDo,
  )

isBadPosting :: Map AccountName AccountType -> Posting -> Bool
isBadPosting typeOf p = case typeOf ! paccount p of
  Expense -> pamount p < 0
  Revenue -> pamount p > 0
  _ -> False

isBadTransaction :: Map AccountName AccountType -> Transaction -> Bool
isBadTransaction typeOf = any (isBadPosting typeOf) . tpostings

main :: IO ()
main = withJournalDo defcliopts $ \j -> do
  let badTransactions = filter (isBadTransaction $ jaccounttypes j) (jtxns j)

  forM_ badTransactions $ \t -> do
    T.putStr (showTransaction t)

  let n = length badTransactions

  when (n > 0) $ do
    putStrLn $ show n <> " bad transactions"
    exitFailure
