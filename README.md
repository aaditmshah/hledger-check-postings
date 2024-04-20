# hledger-check-postings

A custom [hledger script](https://hledger.org/scripting.html#hledger-lib-scripts) to check postings.

## Installation

Clone this repository.

```shell
git clone git@github.com:aaditmshah/hledger-check-postings.git
```

Switch to the project directory.

```shell
cd hledger-check-postings
```

Build the executable.

```shell
cabal build
```

Install the executable.

```shell
cabal install
```

## Usage

If you have set a `$LEDGER_FILE` environment variable then you can simply run the program as follows.

```shell
hledger check-postings
```

This [add-on command](https://hledger.org/scripting.html#add-on-commands) will check whether you have any postings which credit expense accounts or debit revenue accounts. Expense accounts should only be debited and revenue accounts should only be credited. Hence, if you credit an expense account or debit a revenue account then `check-postings` flags the transaction and fails.
