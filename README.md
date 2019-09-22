This is a [Homebrew](https://brew.sh) tap for software that I wrote and not.

Binary bottles are built by the courtesy of Github Actions and are currently available only for Linux on `x86_64`, but this can change in the future.

### Install

Installing any package from this tap is easy, as it usually is:

```sh
brew install dawidd6/tap/$PACKAGE
```

### CI setup

This tap is set up in a way to mostly resemble the [core taps of Homebrew](https://github.com/Homebrew/homebrew-core).

Bottles creation process (for people with push access):
1. Make a new branch locally and switch to it.
2. Modify one existing Formula or add a new one.
3. CI will start and try to first build a bottle with [`brew test-bot`](https://github.com/Homebrew/homebrew-test-bot) and then upload it to [bintray](https://bintray.com/dawidd6/bottles-tap) and force push a new branch named `pr-$PR_NUMBER` to this git repository.
4. If the maintainer (me) is satisfied with the PR, then he runs locally on his machine [a wrapper of `brew pull`](https://github.com/dawidd6/bin/blob/master/brew-pull-tap) and observes how smoothly things are going.
5. ???
6. Profit.

People without push access to this repository, first need to fork it.

### Contributing

If you want to contribute, please submit a PR. I will be more than happy to review it and eventually merge it!
