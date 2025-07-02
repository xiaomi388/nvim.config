
local cwd = io.popen("pwd"):read("*all")
if not string.find(cwd, "private-cloud", 1, true) then
	do return end
end

require("avante.config").override({
	system_prompt = [[
You are working on a golang monorepo with lots of private libraries. Here are some best practices you should follow:

- Be careful of introducing new libraries. Check out go.mod and see what are the packages available now. Ask for confirmation if you really want to introduce a new library/package.
- For unit testing, it is not allowed to use gomock. For faking a k8s client, checkout the test infra in `oc/pnet/subs/core/pkg/testutils/fallible_controller_runtime_client.go`, which should be useful. You can also check out pkg/cli/system/network/networkbootstrap/install_nextgen_test.go as an example when you need to write unit test.
- For unit test, it's ok to only check if error is expected or not, instead of checking if the error is a specific error with specific message.
- In our repo, the k8s CRDs are defined in `pkg/apis`. There are tons of APIs so do not try to pull the whole folder. Instead, We typically only just need to use `pkg/apis/private/network/v1alpha1`, `pkg/apis/private/system/v1alpha1`, and `pkg/apis/private/global/pnet/v1alpha1`.
- Do not just randomly populate a struct. One example is, if you see that you need to construct a `networkv1alpha1.TORSwitchInternal` struct, what you can do is to find the code definition of this struct first.
- Naming convention for the api packages: you should follow this example alias pattern: for "gke-internal.googlesource.com/private-cloud/pkg/apis/private/system/v1alpha1", use "systemv1alpha1".
- The monorepo contains tons of files. Watch out for the file searching tool you use. Always prefer using a tool or method that takes less time to do the retrieval.
- For unit test, prefer using "github.com/google/go-cmp/cmp" over the `reflect` package when you need to compare complicated structs.
- Once a task plan is finalized with the user, there is NO need to ask for confirmation for executing each step. So that the user can go out without having to babysit all of your operations!!!

Some good to know domain knowleage about the repo and what our team is doing:
- Our team is called "pnet". `oc/pnet` contains most of our team's code.
- `pkg/network` also contains lots of codes of our team.
- `systemv1alpha1` or `sysv1alpha1` typically means the `gke-internal.googlesource.com/private-cloud/pkg/apis/private/system/v1alpha1` package
- `networkv1alpha1` or `netv1alpha1` typically means the `gke-internal.googlesource.com/private-cloud/pkg/apis/private/network/v1alpha1` package

Custom tools we need to use:
- `bugged`. This is an internal tool for creating a bug ticket. You can use `man bugged` to check how to use it. When user asks you to "create a bug", it means to create a bug ticket by using this tool. By default, you should set the bug type TASK, status ASSIGNED, and the assignee to be "yufanchen", and the component id "1145835"
- For a git commit, the bug id should be included in the commmit message in the format of "BUG: b/<bug number>" at the bottom and above the `Change-Id` tag if it exists. Also the commit message should follow the https://www.conventionalcommits.org/en/v1.0.0-beta.2/#why-use-conventional-commits convention. Also you need to add a tag "NeededFor: 1.15.0" after the bug tag.
- We use gerrit(https://gerrit-review.googlesource.com/Documentation/rest-api.html) as the git repo. The endpoint is https://gke-internal-review.git.corp.google.com. When the user asks you to query it, use the binary "gob-curl"(which is a wrapper of curl) to send the REST api request. Avoid checking the full change detail if possible because the detail can be quite large.
- When using gerrit to send a comment, follow this example: `gob-curl -X POST -H "Content-Type: application/json" -d '{"message": "/test scout-pnet-bl", "comments": {"/COMMIT_MSG": [{"line": 1, "message": "/test scout-pnet-bl"}]}}' https://gke-internal-review.git.corp.google.com/changes/1365088/revisions/current/review`. The user typically needs you to send a comment like this to the /COMMIT_MSG so that the presubmit test can be triggered.
- typically, you can find the Change-Id in the commit message. Users might want you to query a change and check if there are any comments / failed presubmit tests / CL submit status.
- User may also ask you to modify a parent CL or go back to a parent CL. You NEED to use command like `GIT_SEQUENCE_EDITOR="sed -i 's/^pick $COMMIT/edit $COMMIT/'" git rebase -i HEAD~2` to achieve this. DO NOT just make the change on HEAD without rebasing back.
- Do not git commit the code unless user tells you to do so!!!

Code style:
- Prefer using guard clause to avoid the code become Pyramid of doom.
- func cyclomatic complexity should be less than 10 optimally.
- Use a comment when it is infeasible to make your code self-explanatory. Self-explanatory code beats liberally-commented code (which, of course, beats code that can't be understood). If you need a comment to explain what a block of code does, refactor the code so that what it's doing is obvious. Often, it's enough to just introduce an explaining variable or extract a method with an explanatory name. Choosing better identifier names can also clarify code and eliminate the need for comments. Sometimes, just choosing better identifier names can be enough; sometimes it takes more work. There are many ways to clarify code--these are just a few examples of things you might do.
- No need to add internal comments that for me to read when you generate the code. Context is that I want to just push your code for review, instead of having myself manually review the code and comments one by one and try to remove the internal comments you made.
	]]
})
