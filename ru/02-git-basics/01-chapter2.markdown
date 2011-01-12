# Основы Git #

Если вы хотите начать работать с Git прочитав всего одну главу, то эта глава — то что вам нужно. Здесь рассмотрены все базовые команды, необходимые вам для решения подавляющего большинства задач возникающих при работе с Git. После прочтения этой главы вы научитесь настраивать и инициализировать репозиторий, начинать и прекращать версионный контроль файлов, а также подготавливать и фиксировать изменения. Мы также продемонстрируем вам как настроить игнорирование отдельных файлов или их групп в Git, как быстро и просто отменить ошибочные изменения, как просмотреть историю вашего проекта и изменения между отдельными коммитами (commit), а также как выкладывать (push) и забирать (pull) изменения в/из удаленного (remote) репозитория.

If you can read only one chapter to get going with Git, this is it. This chapter covers every basic command you need to do the vast majority of the things you’ll eventually spend your time doing with Git. By the end of the chapter, you should be able to configure and initialize a repository, begin and stop tracking files, and stage and commit changes. We’ll also show you how to set up Git to ignore certain files and file patterns, how to undo mistakes quickly and easily, how to browse the history of your project and view changes between commits, and how to push and pull from remote repositories.

## Создание репозитория Git ##

Для создания репозитория Git существуют два основных подхода. Первый подход — импорт в Git уже существующего проекта или каталога. Второй — клонирование уже существующего репозитория с сервера.

### Создание репозитория в существующем каталоге ###

Если вы собираетесь начать использовать Git для существующего проекта, то вам необходимо перейти в проектный каталог и в командной строке ввести

If you’re starting to track an existing project in Git, you need to go to the project’s directory and type

	$ git init

Эта команда создает в текущем каталоге новый подкаталог с именем .git содержащий все необходимые файлы репозитория — основу репозитория Git. На этом этапе ваш проект еще не находится под версионным контролем. (В Главе 9 приведено подробное описание файлов содержащихся в только что созданном вами каталоге ".git")

This creates a new subdirectory named .git that contains all of your necessary repository files — a Git repository skeleton. At this point, nothing in your project is tracked yet. (See Chapter 9 for more information about exactly what files are contained in the `.git` directory you just created.)

Если вы хотите добавить под версионный контроль существующие файлы (в отличие от пустого каталога), вам стоит проиндексировать эти файлы и осуществить первую фиксацию изменений. Осуществить это вы можете с помощью нескольких команд git add указывающих индексируемые файлы и последующего коммита:

If you want to start version-controlling existing files (as opposed to an empty directory), you should probably begin tracking those files and do an initial commit. You can accomplish that with a few git add commands that specify the files you want to track, followed by a commit:

	$ git add *.c
	$ git add README
	$ git commit –m 'initial project version'

Мы разберем что делают эти команды чуть позже. На данном этапе, у вас есть репозиторий Git с добавленными файлами и начальным коммитом.

We’ll go over what these commands do in just a minute. At this point, you have a Git repository with tracked files and an initial commit.

### Клонирование Существующего Репозитория ###
### Cloning an Existing Repository ###

Если вы желаете получить копию существующего репозитория Git, например проекта в котором вы хотите поучаствовать, то вам нужна команда git clone. Если вы знакомы с другими системами контроля версий, такими как Subversion, то заметите что команда называется clone, а не checkout. Это важное отличие — Git получает копию практически всех данных, что есть на сервере. Каждая версия каждого файла из истории проекта забирается (pulled) с сервера когда вы выполняете `git clone`. Фактически, если серверный диск выйдет из строя, вы можете использовать любой из клонов на любом из клиентов, для того чтобы вернуть сервер в то состояние, в котором он находился в момент клонирования (вы можете потерять часть серверных правил (server-side hooks) и т.п., но все данные помещенные под версионный контроль будут сохранены, подробнее см. в Главе 4).

If you want to get a copy of an existing Git repository — for example, a project you’d like to contribute to — the command you need is git clone. If you’re familiar with other VCS systems such as Subversion, you’ll notice that the command is clone and not checkout. This is an important distinction — Git receives a copy of nearly all data that the server has. Every version of every file for the history of the project is pulled down when you run `git clone`. In fact, if your server disk gets corrupted, you can use any of the clones on any client to set the server back to the state it was in when it was cloned (you may lose some server-side hooks and such, but all the versioned data would be there—see Chapter 4 for more details).

Клонирование репозитория осуществляется командой `git clone [url]`. Например, если вы хотите клонировать библиотеку Ruby Git известную как Grit, вы можете сделать это следующим образом:

You clone a repository with `git clone [url]`. For example, if you want to clone the Ruby Git library called Grit, you can do so like this:

	$ git clone git://github.com/schacon/grit.git

Эта команда создает каталог с именем "grit", в нем инициализирует каталог `.git`, скачивает все данные для этого репозитория и создает (checks out) рабочую копию последней версии. Если вы зайдете в новый каталог `grit`, вы увидите в нем проектные файлы пригодные для изменения и/или использования. Если вы хотите клонировать репозиторий в каталог отличный от `grit`, вы можете указать это следующим параметром командной строки:

That creates a directory named "grit", initializes a `.git` directory inside it, pulls down all the data for that repository, and checks out a working copy of the latest version. If you go into the new `grit` directory, you’ll see the project files in there, ready to be worked on or used. If you want to clone the repository into a directory named something other than grit, you can specify that as the next command-line option:

	$ git clone git://github.com/schacon/grit.git mygrit

Эта команда делает все то же самое что и предыдущая, только результирующий каталог будет назван mygrit.

That command does the same thing as the previous one, but the target directory is called mygrit.

Git реализует несколько транспортных протоколов, которые вы можете использовать. В предыдущем примере использовался `git://` протокол, вы также можете встретить `http(s)://` или `user@server:/path.git`, использующий транспортный протокол SSH. В Главе 4 представлены все доступные варианты конфигурации сервера для доступа в вашему репозиторию Git, а также их достоинства и недостатки.

Git has a number of different transfer protocols you can use. The previous example uses the `git://` protocol, but you may also see `http(s)://` or `user@server:/path.git`, which uses the SSH transfer protocol. Chapter 4 will introduce all of the available options the server can set up to access your Git repository and the pros and cons of each.

## Запись Изменений в Репозиторий ##
## Recording Changes to the Repository ##

Итак, у вас имеется подлинный репозиторий Git и отладочная(checkout) или рабочая копия файлов для некоторого проекта. Вам хочется делать некоторые изменения и фиксировать "снимки" состояния (snapshots) этих изменений в вашем репозитории каждый раз, когда проект достигает состояния, которое вам хотелось бы сохранить.

You have a bona fide Git repository and a checkout or working copy of the files for that project. You need to make some changes and commit snapshots of those changes into your repository each time the project reaches a state you want to record.

Запомните, каждый файл в вашем рабочем каталоге может находится в одном из двух состояний: под версионным контролем (отслеживаемые) и нет (неотслеживаемые). Отслеживаемые файлы — это те файлы, которые были в последнем слепке состояния проекта (snapshot); они могут быть неизмененными, измененными или подготовленными к коммиту (staged). Неотслеживаемые файлы - это все остальное, любые файлы в вашем рабочем каталоге, которые не входили в ваш последний слепок состояния и не подготовлены к коммиту. Когда вы впервые клонируете репозиторий, все ваши файлы будут отслеживаемыми и неизмененные, потому что вы только взяли из из хранилища (checked them out) и ничего пока не редактировали.

Remember that each file in your working directory can be in one of two states: tracked or untracked. Tracked files are files that were in the last snapshot; they can be unmodified, modified, or staged. Untracked files are everything else - any files in your working directory that were not in your last snapshot and are not in your staging area.  When you first clone a repository, all of your files will be tracked and unmodified because you just checked them out and haven’t edited anything. 

Как только вы отредактируете файлы, Git будет рассматривать их как измененные, т.к. вы изменили их с момента последнего коммита. Вы индексируете (stage) эти изменения и затем фиксируете все индексированные изменения, а затем цикл повторяется. Этот жизненный цикл изображен на рисунке 2-1.

As you edit files, Git sees them as modified, because you’ve changed them since your last commit. You stage these modified files and then commit all your staged changes, and the cycle repeats. This lifecycle is illustrated in Figure 2-1.

Insert 18333fig0201.png 
Рисунок 2-1. Жизненный цикл состояния ваших файлов.
Figure 2-1. The lifecycle of the status of your files.

### Определение Состояния Ваших Файлов ###
### Checking the Status of Your Files ###

Основной инструмент используемый вами для определения какие файлы в каком состоянии находятся — это команда git status. Если вы выполните эту команду сразу после клонирования, вы увидите что-то вроде этого:

The main tool you use to determine which files are in which state is the git status command. If you run this command directly after a clone, you should see something like this:

	$ git status
	# On branch master
	nothing to commit (working directory clean)

Это означает, что у вас чистый рабочий каталог, другими словами — в нем нет отслеживаемых и измененный файлов. Git также не обнаружил неотслеживаемых файлов, в противном случае они бы были перечислены здесь. И наконец команда сообщает вам на какой ветке (branch) вы сейчас находитесь. Пока вы всегда на ветке master, это ветка по умолчанию, в этой главе это не важно. В следующей главе подробно рассказывается про ветки и ссылки.

This means you have a clean working directory—in other words, there are no tracked and modified files. Git also doesn’t see any untracked files, or they would be listed here. Finally, the command tells you which branch you’re on. For now, that is always master, which is the default; you won’t worry about it here. The next chapter will go over branches and references in detail.

Предположим вы добавили новый файл в ваш проект, простой README файл. Если этого файла раньше не было, и вы выполните `git status`, вы увидите ваш неотслеживаемый файл как-то так:

Let’s say you add a new file to your project, a simple README file. If the file didn’t exist before, and you run `git status`, you see your untracked file like so:

	$ vim README
	$ git status
	# On branch master
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#	README
	nothing added to commit but untracked files present (use "git add" to track)

Вы можете видеть, что ваш новый файл README неотслеживаемый, т.к. он находится в секции “Untracked files” в выводе команды status. Неотслеживаемый файл обычно означает, что Git нашел файл отсутствующий в предыдущем снимке состояния (коммите); Git не станет добавлять его в ваши коммиты, пока вы явно это ему не укажете. Это предохраняет вас от случайного добавления в репозиторий сгенерированных двоичных файлов или каких-либо других, которые вы и не думали добавлять. Вы хотите добавить README, так что давайте сделаем это.

You can see that your new README file is untracked, because it’s under the “Untracked files” heading in your status output. Untracked basically means that Git sees a file you didn’t have in the previous snapshot (commit); Git won’t start including it in your commit snapshots until you explicitly tell it to do so. It does this so you don’t accidentally begin including generated binary files or other files that you did not mean to include. You do want to start including README, so let’s start tracking the file.

### Отслеживание Новых Файлов ###
### Tracking New Files ###

Для того чтобы начать отслеживать (добавить под версионный контроль) новый файл, вы используете команду `git add`. Чтобы начать отслеживание файла README, вы можете выполнить:

In order to begin tracking a new file, you use the command `git add`. To begin tracking the README file, you can run this:

	$ git add README

Если вы снова выполните команду status, то увидите, что файл README теперь отслеживаемый и индексированный:

If you run your status command again, you can see that your README file is now tracked and staged:

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#

Вы можете видеть что файл проиндексирован по тому, что он находится в секции “Changes to be committed”. Если вы выполните коммит в этот момент, то версия файла, существовавшая на момент выполнения вами команды git add, будет добавлена в историю снимков состояния. Вы помните, что когда вы ранее выполнили git init, вы затем выполнили git add (files) - это было сделано для того, чтобы добавить файлы в вашем каталоге под версионный контроль. Команда git add принимает параметром путь к файлу или каталогу, если это каталог, команда рекурсивно добавляет (индексирует) все файлы в данном каталоге.

You can tell that it’s staged because it’s under the “Changes to be committed” heading. If you commit at this point, the version of the file at the time you ran git add is what will be in the historical snapshot. You may recall that when you ran git init earlier, you then ran git add (files) — that was to begin tracking files in your directory. The git add command takes a path name for either a file or a directory; if it’s a directory, the command adds all the files in that directory recursively.

### Индексация Измененных Файлов ###
### Staging Modified Files ###

Давайте модифицируем файл уже находящийся под версионным контролем. Если вы измените отслеживаемый файл `benchmarks.rb`, и, после этого снова выполните команду `status`, то результат будет примерно следующим:

Let’s change a file that was already tracked. If you change a previously tracked file called `benchmarks.rb` and then run your `status` command again, you get something that looks like this:

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#	modified:   benchmarks.rb
	#

Файл benchmarks.rb находится в секции “Changed but not updated” — это означает, что отслеживаемый файл был изменен в рабочем каталоге, но пока не проиндексирован. Чтобы проиндексировать его, необходимо выполнить команду `git add` (это многофункциональная команда, она используется для добавления под версионный контроль новых файлов, для индексации изменений, а также для других целей, например для указания файлов с исправленным конфликтом слияния). Выполним `git add`, чтобы проиндексировать benchmarks.rb, а затем снова выполним `git status`:

The benchmarks.rb file appears under a section named “Changed but not updated” — which means that a file that is tracked has been modified in the working directory but not yet staged. To stage it, you run the `git add` command (it’s a multipurpose command — you use it to begin tracking new files, to stage files, and to do other things like marking merge-conflicted files as resolved). Let’s run `git add` now to stage the benchmarks.rb file, and then run `git status` again:

	$ git add benchmarks.rb
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#	modified:   benchmarks.rb
	#

Теперь оба файла проиндексированы и войдут в следующий коммит. В этот момент, вы, предположим, вспомнили одно небольшое изменение, которое вы хотите сделать в benchmarks.rb до фиксации. Вы открываете файл, вносите и сохраняете необходимые изменения и вроде бы готовы к коммиту. Но давайте-ка еще раз выполним `git status`:

Both files are staged and will go into your next commit. At this point, suppose you remember one little change that you want to make in benchmarks.rb before you commit it. You open it again and make that change, and you’re ready to commit. However, let’s run `git status` one more time:

	$ vim benchmarks.rb 
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#	modified:   benchmarks.rb
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#	modified:   benchmarks.rb
	#

Что за черт? Теперь benchmarks.rb отображается как проиндексированный и непроиндексированный одновременно. Как такое возможно? Такая ситуация наглядно демонстрирует, что Git индексирует файл в точности в том состоянии, в котором он находился, когда вы выполнили команду git add. Если вы выполните коммит сейчас, то файл benchmarks.rb попадет в коммит в том состоянии, в котором он находился когда вы последний раз выполняли команду git add, а не в том, в котором он находится в вашем рабочем каталоге в момент выполнения git commit. Если вы изменили файл после выполнения `git add`, вам придется снова выполнить `git add`, чтобы проиндексировать последнюю версию файла:

What the heck? Now benchmarks.rb is listed as both staged and unstaged. How is that possible? It turns out that Git stages a file exactly as it is when you run the git add command. If you commit now, the version of benchmarks.rb as it was when you last ran the git add command is how it will go into the commit, not the version of the file as it looks in your working directory when you run git commit. If you modify a file after you run `git add`, you have to run `git add` again to stage the latest version of the file:

	$ git add benchmarks.rb
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#	modified:   benchmarks.rb
	#

### Игнорирование файлов ###
### Ignoring Files ###

Зачастую, у вас имеется группа файлов, которые вы не только не хотите автоматически добавлять в репозиторий, но и видеть в списках неотслеживаемых. К таким файлам обычно относятся автоматически генерируемые файлы (различные логи, результаты построения программ и т.п.). В таком случае, вы можете создать файл, перечисляющий шаблоны для поиска таких файлов, и называющийся .gitignore. Вот пример файла .gitignore:

Often, you’ll have a class of files that you don’t want Git to automatically add or even show you as being untracked. These are generally automatically generated files such as log files or files produced by your build system. In such cases, you can create a file listing patterns to match them named .gitignore.  Here is an example .gitignore file:

	$ cat .gitignore
	*.[oa]
	*~

Первая строка предписывает Git-у игнорировать любые файлы заканчивающиеся на .o или .a — объектные и архивные файлы, которые могут появиться во время сборки кода. Вторая строка предписывает игнорировать все файлы заканчивающиеся на тильду (`~`), которая используется во многих текстовых редакторах, например Emacs, для обозначения временных файлов. Вы можете также включить каталоги log, tmp или pid; автоматически создаваемую документацию; и т.д. и т.п. Хорошая практика заключается в настройке файла .gitignore до того, как начать серьезно работать, это защитит вас от случайного добавления в репозиторий файлов, которых вы там видеть не хотите.

The first line tells Git to ignore any files ending in .o or .a — object and archive files that may be the product of building your code. The second line tells Git to ignore all files that end with a tilde (`~`), which is used by many text editors such as Emacs to mark temporary files. You may also include a log, tmp, or pid directory; automatically generated documentation; and so on. Setting up a .gitignore file before you get going is generally a good idea so you don’t accidentally commit files that you really don’t want in your Git repository.

в файле .gitignore к шаблонам применяются следующие правила:

The rules for the patterns you can put in the .gitignore file are as follows:

*	Пустые строки, а также строки начинающиеся с # игнорируются.
*	Можно использовать стандартные glob шаблоны.
*	Можно заканчивать шаблон символом слэша (`/`) для указания каталога
*	Можно инвертировать шаблон, использовав восклицательный знак (`!`) в качестве первого символа.

*	Blank lines or lines starting with # are ignored.
*	Standard glob patterns work.
*	You can end patterns with a forward slash (`/`) to specify a directory.
*	You can negate a pattern by starting it with an exclamation point (`!`).

Glob шаблоны представляют собой упрощенные регулярные выражения используемые командными интерпретаторами. Символ `*` соответствует 0 или более любых символов; последовательность `[abc]` - любому символу из указанных в скобках (в данном примере a, b или c); знак вопроса (`?`) соответствует любому одному символу; `[0-9]` - соответствует любому символу из интервала (в данном случае от 0 до 9).

Glob patterns are like simplified regular expressions that shells use. An asterisk (`*`) matches zero or more characters; `[abc]` matches any character inside the brackets (in this case a, b, or c); a question mark (`?`) matches a single character; and brackets enclosing characters separated by a hyphen(`[0-9]`) matches any character between them (in this case 0 through 9) . 

Вот еще один пример файла .gitignore:

Here is another example .gitignore file:

	# комментарий – эта строка игнорируется
	*.a       # не обрабатывать файлы имя которых заканчивается на .a
	!lib.a    # НО отслеживать файл lib.a, несмотря на то, что мы игнорируем все .a файлы с помощью предыдущего правила
	/TODO     # игнорировать только файл TODO находящийся в корневом каталоге, не относится к файлам вида subdir/TODO
	build/    # игнорировать все файлы в каталоге build/
	doc/*.txt # игнорировать doc/notes.txt, но не doc/server/arch.txt

	# a comment – this is ignored
	*.a       # no .a files
	!lib.a    # but do track lib.a, even though you're ignoring .a files above
	/TODO     # only ignore the root TODO file, not subdir/TODO
	build/    # ignore all files in the build/ directory
	doc/*.txt # ignore doc/notes.txt, but not doc/server/arch.txt

### Просмотр Ваших Индексированных и Неиндексированных Изменений ###
### Viewing Your Staged and Unstaged Changes ###

Если результат работы команды `git status` недостаточно информативен для вас — вам хочется знать, что конкретно поменялось, а не только какие файлы были изменены — вы можете использовать команду `git diff`. Позже мы рассмотрим команду `git diff` подробнее; вы скорее всего будете использовать эту команду для получения ответов на два вопроса: что вы изменили но еще не проиндексировали, и что вы проиндексировали и собираетесь фиксировать. Если `git status` отвечает на эти вопросы слишком обобщенно, то `git diff` показывает вам непосредственно добавленные и удаленные строки - собственно заплатку (patch).

If the `git status` command is too vague for you — you want to know exactly what you changed, not just which files were changed — you can use the `git diff` command. We’ll cover `git diff` in more detail later; but you’ll probably use it most often to answer these two questions: What have you changed but not yet staged? And what have you staged that you are about to commit? Although `git status` answers those questions very generally, `git diff` shows you the exact lines added and removed — the patch, as it were. 

Допустим вы снова изменили и проиндексировали файл README, а затем изменили файл benchmarks.rb без индексирования. Если вы выполните команду `status`, вы опять увидите что-то вроде:

Let’s say you edit and stage the README file again and then edit the benchmarks.rb file without staging it. If you run your `status` command, you once again see something like this:

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	new file:   README
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#	modified:   benchmarks.rb
	#

Чтобы увидеть что же вы изменили, но пока не проиндексировали, наберите `git diff` без аргументов:

To see what you’ve changed but not yet staged, type `git diff` with no other arguments:

	$ git diff
	diff --git a/benchmarks.rb b/benchmarks.rb
	index 3cb747f..da65585 100644
	--- a/benchmarks.rb
	+++ b/benchmarks.rb
	@@ -36,6 +36,10 @@ def main
	           @commit.parents[0].parents[0].parents[0]
	         end

	+        run_code(x, 'commits 1') do
	+          git.commits.size
	+        end
	+
	         run_code(x, 'commits 2') do
	           log = git.commits('master', 15)
	           log.size

Эта команда сравнивает содержимое вашего рабочего каталога с содержимым индекса. Результат показывает еще не проиндексированные изменения.

That command compares what is in your working directory with what is in your staging area. The result tells you the changes you’ve made that you haven’t yet staged.

Если вы хотите посмотреть, что вы проиндексировали и что войдет в следующий коммит, вы можете выполнить `git diff –-cached`. (В Git версии 1.6.1 и выше, вы также можете использовать `git diff –-staged`, которая легче запоминается.) Эта команда сравнивает ваши индексированные изменения с последним коммитом:

If you want to see what you’ve staged that will go into your next commit, you can use `git diff –-cached`. (In Git versions 1.6.1 and later, you can also use `git diff –-staged`, which may be easier to remember.) This command compares your staged changes to your last commit:

	$ git diff --cached
	diff --git a/README b/README
	new file mode 100644
	index 0000000..03902a1
	--- /dev/null
	+++ b/README2
	@@ -0,0 +1,5 @@
	+grit
	+ by Tom Preston-Werner, Chris Wanstrath
	+ http://github.com/mojombo/grit
	+
	+Grit is a Ruby library for extracting information from a Git repository

Важно отметить, что `git diff` сама по себе не показывает все изменения сделанные с последнего коммита — только те, что еще не проиндексированы. Такое поведение может сбивать с толку, так как если вы проиндексируете все свои изменения, то `git diff` ничего не вернет.

It’s important to note that `git diff` by itself doesn’t show all changes made since your last commit — only changes that are still unstaged. This can be confusing, because if you’ve staged all of your changes, `git diff` will give you no output.

Другой пример, вы проиндексировали файл benchmarks.rb и затем изменили его, вы можете использовать `git diff` для просмотра как индексированных изменений в этом файле, так и тех, что пока не проиндексированны:

For another example, if you stage the benchmarks.rb file and then edit it, you can use `git diff` to see the changes in the file that are staged and the changes that are unstaged:

	$ git add benchmarks.rb
	$ echo '# test line' >> benchmarks.rb
	$ git status
	# On branch master
	#
	# Changes to be committed:
	#
	#	modified:   benchmarks.rb
	#
	# Changed but not updated:
	#
	#	modified:   benchmarks.rb
	#

Теперь вы можете используя `git diff` посмотреть непроиндексированные изменения

Now you can use `git diff` to see what is still unstaged

	$ git diff 
	diff --git a/benchmarks.rb b/benchmarks.rb
	index e445e28..86b2f7c 100644
	--- a/benchmarks.rb
	+++ b/benchmarks.rb
	@@ -127,3 +127,4 @@ end
	 main()

	 ##pp Grit::GitRuby.cache_client.stats 
	+# test line

а также уже проиндексированные, используя `git diff --cached`:

and `git diff --cached` to see what you’ve staged so far:

	$ git diff --cached
	diff --git a/benchmarks.rb b/benchmarks.rb
	index 3cb747f..e445e28 100644
	--- a/benchmarks.rb
	+++ b/benchmarks.rb
	@@ -36,6 +36,10 @@ def main
	          @commit.parents[0].parents[0].parents[0]
	        end

	+        run_code(x, 'commits 1') do
	+          git.commits.size
	+        end
	+              
	        run_code(x, 'commits 2') do
	          log = git.commits('master', 15)
	          log.size

### Фиксация Ваших Изменений ###
### Committing Your Changes ###

Теперь, когда ваш индекс настроен так как вам и хотелось, вы можете зафиксировать ваши изменения. Запомните, все что до сих пор не проиндексировано — любые файлы, созданные или измененные вами, и для которых вы не выполнили `git add` после момента редактирования — не войдут в этот коммит. Они останутся измененными файлами на вашем диске.
В нашем случае, когда вы в последний раз выполняли `git status`, вы видели что все проиндексировано, и вот, вы готовы к коммиту. Простейший способ зафиксировать ваши изменения — это набрать `git commit`:

Now that your staging area is set up the way you want it, you can commit your changes. Remember that anything that is still unstaged — any files you have created or modified that you haven’t run `git add` on since you edited them — won’t go into this commit. They will stay as modified files on your disk.
In this case, the last time you ran `git status`, you saw that everything was staged, so you’re ready to commit your changes. The simplest way to commit is to type `git commit`:

	$ git commit

Эта команда откроет выбранный вами текстовый редактор. (Редактор устанавливается вашей системной переменной `$EDITOR` — обычно это vim или emacs, хотя вы можете установить ваш любимый с помощью команды `git config --global core.editor` как было показано в Главе 1).

Doing so launches your editor of choice. (This is set by your shell’s `$EDITOR` environment variable — usually vim or emacs, although you can configure it with whatever you want using the `git config --global core.editor` command as you saw in Chapter 1). 

В редакторе будет отображен следующий текст (это пример окна Vim-а):

The editor displays the following text (this example is a Vim screen):

	# Please enter the commit message for your changes. Lines starting
	# with '#' will be ignored, and an empty message aborts the commit.
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       new file:   README
	#       modified:   benchmarks.rb 
	~
	~
	~
	".git/COMMIT_EDITMSG" 10L, 283C

Вы можете видеть, что комментарий по умолчанию для коммита содержит закомментированный результат работы ("выхлоп") команды `git status` и сверху одну пустую строку. Вы можете удалить эти комментарии и набрать ваше сообщение или же оставить их, чтобы впоследствии помочь вам вспомнить — что же вы фиксировали. (Для еще более подробного напоминания, что же вы именно меняли, вы можете передать аргумент `-v` в команду `git commit`. Это приведет к тому, что в комментарий будет помещена также разница/diff ваших изменений, таким образом вы сможете точно увидеть что же вы сделали.) Когда вы выходите из редактора, Git создает ваш коммит с этим сообщением (с комментариями и выводом diff-а).

You can see that the default commit message contains the latest output of the `git status` command commented out and one empty line on top. You can remove these comments and type your commit message, or you can leave them there to help you remember what you’re committing. (For an even more explicit reminder of what you’ve modified, you can pass the `-v` option to `git commit`. Doing so also puts the diff of your change in the editor so you can see exactly what you did.) When you exit the editor, Git creates your commit with that commit message (with the comments and diff stripped out).

Другой способ: вы можете набрать ваш комментарий к коммиту в командной строке вместе с командой `commit` указав его после параметра -m, как в следующем примере:

Alternatively, you can type your commit message inline with the `commit` command by specifying it after a -m flag, like this:

	$ git commit -m "Story 182: Fix benchmarks for speed"
	[master]: created 463dc4f: "Fix benchmarks for speed"
	 2 files changed, 3 insertions(+), 0 deletions(-)
	 create mode 100644 README

Итак, вы создали свой первый коммит! Вы можете видеть, что коммит вывел вам немного информации о себе: на какую ветку вы выполнили коммит (master), какая контрольная сумма SHA-1 у этого коммита (`463dc4f`), сколько файлов было изменено, а также статистику по добавленным/удаленным строкам в этом коммите.

Now you’ve created your first commit! You can see that the commit has given you some output about itself: which branch you committed to (master), what SHA-1 checksum the commit has (`463dc4f`), how many files were changed, and statistics about lines added and removed in the commit.

Запомните, что коммит сохраняет снимок состояния вашего индекса. Все, что вы не проиндексировали, так и торчит в рабочем каталоге как измененное; вы можете сделать еще один коммит чтобы добавить эти изменения в репозиторий. Каждый раз, когда вы делаете коммит, вы сохраняете снимок состояния вашего проекта который позже вы можете восстановить или с которым можно сравнить текущее состояние.

Remember that the commit records the snapshot you set up in your staging area. Anything you didn’t stage is still sitting there modified; you can do another commit to add it to your history. Every time you perform a commit, you’re recording a snapshot of your project that you can revert to or compare to later.

### Игнорирование Индексации ###
### Skipping the Staging Area ###

Несмотря на то, что индекс может быть удивительно полезным для создания коммитов точно как вам и хотелось, он временами несколько сложнее, чем вам нужно в процессе работы. Если у вас есть желание пропустить явное индексирование, Git предоставляет простой способ. Добавление параметра `-a` в команду `git commit` заставляет Git автоматически индексировать каждый уже отслеживаемый на момент коммита файл, позволяя вам обойтись без `git add`:

Although it can be amazingly useful for crafting commits exactly how you want them, the staging area is sometimes a bit more complex than you need in your workflow. If you want to skip the staging area, Git provides a simple shortcut. Providing the `-a` option to the `git commit` command makes Git automatically stage every file that is already tracked before doing the commit, letting you skip the `git add` part:

	$ git status
	# On branch master
	#
	# Changed but not updated:
	#
	#	modified:   benchmarks.rb
	#
	$ git commit -a -m 'added new benchmarks'
	[master 83e38c7] added new benchmarks
	 1 files changed, 5 insertions(+), 0 deletions(-)

Обратите внимание на то, что в данном случае перед коммитом вам не нужно выполнять `git add` для файла benchmarks.rb.

Notice how you don’t have to run `git add` on the benchmarks.rb file in this case before you commit.

### Удаление Файлов ###
### Removing Files ###

Для того чтобы удалить файл из Git, вам необходимо удалить его из отслеживаемых файлов (точнее, удалить его из вашего индекса) а затем выполнить коммит. Это позволяет сделать команда `git rm`, которая также удаляет файл из вашего рабочего каталога, так что вы в следующий раз не увидите его как "неотслеживаемый".

To remove a file from Git, you have to remove it from your tracked files (more accurately, remove it from your staging area) and then commit. The `git rm` command does that and also removes the file from your working directory so you don’t see it as an untracked file next time around.

Если вы просто удалите файл из вашего рабочего каталога, он будет показан в секции "Измененные но не обновленные" (читай не проиндексированные) вывода команды `git status`:

If you simply remove the file from your working directory, it shows up under the “Changed but not updated” (that is, _unstaged_) area of your `git status` output:

	$ rm grit.gemspec
	$ git status
	# On branch master
	#
	# Changed but not updated:
	#   (use "git add/rm <file>..." to update what will be committed)
	#
	#       deleted:    grit.gemspec
	#

Затем, если вы выполните команду `git rm`, она проиндексирует удаление файла:

Then, if you run `git rm`, it stages the file’s removal:

	$ git rm grit.gemspec
	rm 'grit.gemspec'
	$ git status
	# On branch master
	#
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       deleted:    grit.gemspec
	#

После следующего коммита, файл исчезнет и больше не будет отслеживаться. Если вы изменили файл и уже проиндексировали его, вы должны использовать принудительное удаление с помощью параметра `-f`. Это сделано для повышения безопасности, чтобы предотвратить ошибочное удаление данных, которые еще не были записаны в снимок состояния и которые нельзя восстановить из Git.

The next time you commit, the file will be gone and no longer tracked. If you modified the file and added it to the index already, you must force the removal with the `-f` option. This is a safety feature to prevent accidental removal of data that hasn’t yet been recorded in a snapshot and that can’t be recovered from Git.

Другая полезная штука, которую вы можете захотеть сделать — это удалить файл из индекса, оставив его при этом в вашем рабочем каталоге. Другими словами, вы можете захотеть оставить файл на вашем винчестере, и убрать его из под бдительного ока Git-а. Это особенно полезно, если вы забыли добавить что-то в ваш файл `.gitignore` и по-ошибке проиндексировали, например большой файл с логами, или куча промежуточных файлов компилляции. Чтобы это сделать, используйте параметр `--cached`:

Another useful thing you may want to do is to keep the file in your working tree but remove it from your staging area. In other words, you may want to keep the file on your hard drive but not have Git track it anymore. This is particularly useful if you forgot to add something to your `.gitignore` file and accidentally added it, like a large log file or a bunch of `.a` compiled files. To do this, use the `--cached` option:

	$ git rm --cached readme.txt

В команду `git rm` вы можете передавать файлы, каталоги или glob-шаблоны. Это означает, что вы можете вытворять что-то вроде:

You can pass files, directories, and file-glob patterns to the `git rm` command. That means you can do things such as

	$ git rm log/\*.log

Обратите внимание на обратный слэш (`\`) перед `*`. Это обязательно, т.к. Git использует свой собственный обработчик имен файлов в добавок к обработчику вашего командного интерпретатора. Эта команда удаляет все файлы которые имеют расширение `.log` в каталоге `log/`. Или же вы можете сделать вот так:

Note the backslash (`\`) in front of the `*`. This is necessary because Git does its own filename expansion in addition to your shell’s filename expansion. This command removes all files that have the `.log` extension in the `log/` directory. Or, you can do something like this:

	$ git rm \*~

Эта команда удаляет все файлы чьи именя заканчиваются на `~`.

This command removes all files that end with `~`.

### Перемещение Файлов ###
### Moving Files ###

В отличие от многих других систем версионного контроля, Git не отслеживает непосредственно перемещение файла. Если вы переименовываете файл в репозитории, то в Git не сохраняется никаких метаданных которые бы могли сообщить Git что вы переименовали файл. Однако, Git достаточно догадлив в плане обнаружения перемещений постфактум — мы рассмотрим обнаружение перемещения файлов чуть позже.

Unlike many other VCS systems, Git doesn’t explicitly track file movement. If you rename a file in Git, no metadata is stored in Git that tells it you renamed the file. However, Git is pretty smart about figuring that out after the fact — we’ll deal with detecting file movement a bit later.

Таким образом наличие в Git команды `mv` выглядит несколько странным. Если вам хочется переименовать файл в Git, вы можете сделать что-то вроде:

Thus it’s a bit confusing that Git has a `mv` command. If you want to rename a file in Git, you can run something like

	$ git mv file_from file_to

и это отлично сработает. На самом деле, если вы выполните что-то вроде этого и посмотрите на статус, вы увидите что Git считает это переименованным файлом:

and it works fine. In fact, if you run something like this and look at the status, you’ll see that Git considers it a renamed file:

	$ git mv README.txt README
	$ git status
	# On branch master
	# Your branch is ahead of 'origin/master' by 1 commit.
	#
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       renamed:    README.txt -> README
	#

Однако, это эквивалентно выполнению следующих команд:

However, this is equivalent to running something like this:

	$ mv README.txt README
	$ git rm README.txt
	$ git add README

Git неявно определяет, что было переименование, поэтому не важно переименуете вы файл так или используя команду `mv`. Единственное отличие состоит лишь в том, что `mv` это одна команда вместо трех — это <convenience function>. Важнее другое — вы можете использовать любой способ/программу чтобы переименовать файл, и затем перед коммитом выполнить add/rm.

Git figures out that it’s a rename implicitly, so it doesn’t matter if you rename a file that way or with the `mv` command. The only real difference is that `mv` is one command instead of three — it’s a convenience function. More important, you can use any tool you like to rename a file, and address the add/rm later, before you commit.

## Просмотр Истории Коммитов ##
## Viewing the Commit History ##

После того, как вы создадите несколько коммитов, или же вы склонируете репозиторий с уже существующей историей коммитов, вы вероятно захотите оглянуться назад и узнать что же происходило с этим репозиторием. Наиболее простой и в то же время мощный инструмент для этого — команда `git log`.

After you have created several commits, or if you have cloned a repository with an existing commit history, you’ll probably want to look back to see what has happened. The most basic and powerful tool to do this is the `git log` command.

Данные примеры используют очень простой проект названный simplegit, который я часто использую для демонстраций. Чтобы получить этот проект выполните:

These examples use a very simple project called simplegit that I often use for demonstrations. To get the project, run 

	git clone git://github.com/schacon/simplegit-progit.git

В результате выполнения `git log` в данном проекте, вы должны получить что-то вроде этого:

When you run `git log` in this project, you should get output that looks something like this:

	$ git log
	commit ca82a6dff817ec66f44342007202690a93763949
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Mar 17 21:52:11 2008 -0700

	    changed the version number

	commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sat Mar 15 16:40:33 2008 -0700

	    removed unnecessary test code

	commit a11bef06a3f659402fe7563abf99ad00de2209e6
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sat Mar 15 10:31:28 2008 -0700

	    first commit

По умолчанию, без аргументов, `git log` выводит список коммитов созданных в данном репозитории в обратном хронологическом порядке. Т.е. самые последние коммиты показываются первыми. Как вы можете видеть, эта команда отображает каждый коммит вместе с его контрольной суммой SHA-1, именем и электронной почтой автора, датой создания и комментарием.

By default, with no arguments, `git log` lists the commits made in that repository in reverse chronological order. That is, the most recent commits show up first. As you can see, this command lists each commit with its SHA-1 checksum, the author’s name and e-mail, the date written, and the commit message.

Существует превеликое множество параметров команды `git log` и их комбинаций, для того чтобы показать вам именно то, что вы ищете. Здесь мы покажем вам несколько наиболее часто применяемых.

A huge number and variety of options to the `git log` command are available to show you exactly what you’re looking for. Here, we’ll show you some of the most-used options.

Один из наиболее полезных параметров — это `-p`, который показывает дельту(разницу/diff) привнесенную каждым коммитом. Вы также можете использовать `-2`, что ограничит вывод до 2-х последних записей:

One of the more helpful options is `-p`, which shows the diff introduced in each commit. You can also use `-2`, which limits the output to only the last two entries:

	$ git log –p -2
	commit ca82a6dff817ec66f44342007202690a93763949
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Mar 17 21:52:11 2008 -0700

	    changed the version number

	diff --git a/Rakefile b/Rakefile
	index a874b73..8f94139 100644
	--- a/Rakefile
	+++ b/Rakefile
	@@ -5,7 +5,7 @@ require 'rake/gempackagetask'
	 spec = Gem::Specification.new do |s|
	-    s.version   =   "0.1.0"
	+    s.version   =   "0.1.1"
	     s.author    =   "Scott Chacon"

	commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sat Mar 15 16:40:33 2008 -0700

	    removed unnecessary test code

	diff --git a/lib/simplegit.rb b/lib/simplegit.rb
	index a0a60ae..47c6340 100644
	--- a/lib/simplegit.rb
	+++ b/lib/simplegit.rb
	@@ -18,8 +18,3 @@ class SimpleGit
	     end

	 end
	-
	-if $0 == __FILE__
	-  git = SimpleGit.new
	-  puts git.show
	-end
	\ No newline at end of file

Этот параметр показывает не только ту же самую информацию, но и привнесенные изменения, отображаемые непосредственно после каждого коммита. Это очень удобно для инспекций кода или для того чтобы быстро посмотреть что происходило в результате последовательности коммитов добавленных коллегой.
С командой `git log` вы также можете использовать группы суммирующих параметров. Например, если выхотите получить некоторую краткую статистику по каждому коммиту, вы можете использовать параметр `--stat`:

This option displays the same information but with a diff directly following each entry. This is very helpful for code review or to quickly browse what happened during a series of commits that a collaborator has added.
You can also use a series of summarizing options with `git log`. For example, if you want to see some abbreviated stats for each commit, you can use the `--stat` option:

	$ git log --stat 
	commit ca82a6dff817ec66f44342007202690a93763949
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Mar 17 21:52:11 2008 -0700

	    changed the version number

	 Rakefile |    2 +-
	 1 files changed, 1 insertions(+), 1 deletions(-)

	commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sat Mar 15 16:40:33 2008 -0700

	    removed unnecessary test code

	 lib/simplegit.rb |    5 -----
	 1 files changed, 0 insertions(+), 5 deletions(-)

	commit a11bef06a3f659402fe7563abf99ad00de2209e6
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sat Mar 15 10:31:28 2008 -0700

	    first commit

	 README           |    6 ++++++
	 Rakefile         |   23 +++++++++++++++++++++++
	 lib/simplegit.rb |   25 +++++++++++++++++++++++++
	 3 files changed, 54 insertions(+), 0 deletions(-)

Как видно из лога, параметр `--stat` выводит под каждым коммитом список измененных файлов, количество измененных файлов, а также количество добавленных и удаленных строк в этих файлах. Он также выводит сводную информацию в конце.
Другой действительно полезный параметр — это `--pretty`. Он позволяет изменить формат вывода лога. Для вас доступны несколько предустановленных вариантов. Параметр `oneline` выводит каждый коммит в одну строку, что удобно если вы просматриваете большое количество коммитов. В дополнение к этому, параметры `short`, `full`, и `fuller` практически не меняя формат вывода позволяют выводить меньше или больше деталей соответственно:

As you can see, the `--stat` option prints below each commit entry a list of modified files, how many files were changed, and how many lines in those files were added and removed. It also puts a summary of the information at the end.
Another really useful option is `--pretty`. This option changes the log output to formats other than the default. A few prebuilt options are available for you to use. The oneline option prints each commit on a single line, which is useful if you’re looking at a lot of commits. In addition, the `short`, `full`, and `fuller` options show the output in roughly the same format but with less or more information, respectively:

	$ git log --pretty=oneline
	ca82a6dff817ec66f44342007202690a93763949 changed the version number
	085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 removed unnecessary test code
	a11bef06a3f659402fe7563abf99ad00de2209e6 first commit

Наиболее интересный параметр — это `format`, который позволяет вам полностью создать собственный формат вывода лога. Это особенно полезно, когда вы создаете отчеты для автоматического разбора(парсинга) — поскольку вы явно задаете формат и уверены в том, что он не будет изменяться при обновлениях Git:

The most interesting option is `format`, which allows you to specify your own log output format. This is especially useful when you’re generating output for machine parsing — because you specify the format explicitly, you know it won’t change with updates to Git:

	$ git log --pretty=format:"%h - %an, %ar : %s"
	ca82a6d - Scott Chacon, 11 months ago : changed the version number
	085bb3b - Scott Chacon, 11 months ago : removed unnecessary test code
	a11bef0 - Scott Chacon, 11 months ago : first commit

Таблица 2-1 содержит список наиболее полезных параметров формата.

	Параметр	Описание выводимых данных
	%H	Хэш коммита
	%h	Сокращенный хэш коммита
	%T	Хэш дерева
	%t	Сокращенных хэш дерева
	%P	Хэши родительских коммитов
	%p	Сокращенные хэши родительских коммитов
	%an	Имя автора
	%ae	Электронная почта автора
	%ad	Дата автора (формат соответствует параметру –date= )
	%ar	Дата автора, относительная (пр. "2 мес. назад")
	%cn	Имя коммиттера
	%ce	Электронная почта коммиттера
	%cd	Дата коммиттера
	%cr	Дата коммиттера, относительная
	%s	Комментарий

Table 2-1 lists some of the more useful options that format takes.

	Option	Description of Output
	%H	Commit hash
	%h	Abbreviated commit hash
	%T	Tree hash
	%t	Abbreviated tree hash
	%P	Parent hashes
	%p	Abbreviated parent hashes
	%an	Author name
	%ae	Author e-mail
	%ad	Author date (format respects the –date= option)
	%ar	Author date, relative
	%cn	Committer name
	%ce	Committer email
	%cd	Committer date
	%cr	Committer date, relative
	%s	Subject

Вы может быть интересно в чем же разница между _автором_ и _коммиттером_. Автор — это человек, изначально сделавший работу, тогда как коммиттер — это человек, который последним применил эту работу. Так что если вы послали патч(заплатку) в проект и один из основных разработчиков применил этот патч, вы оба не будете забыты — вы как автор а разработчик как коммиттер. Мы чуть подробнее рассмотрим это различие в Главе 5.

You may be wondering what the difference is between _author_ and _committer_. The author is the person who originally wrote the work, whereas the committer is the person who last applied the work. So, if you send in a patch to a project and one of the core members applies the patch, both of you get credit — you as the author and the core member as the committer. We’ll cover this distinction a bit more in Chapter 5.

Параметры oneline и format также полезны с другим параметром команды `log` — `--graph`. Этот параметр добавляет миленький ASCII граф показывающий вашу ветку и историю слияний, **which we can see our copy of the Grit project repository**:

The oneline and format options are particularly useful with another `log` option called `--graph`. This option adds a nice little ASCII graph showing your branch and merge history, which we can see our copy of the Grit project repository:

	$ git log --pretty=format:"%h %s" --graph
	* 2d3acf9 ignore errors from SIGCHLD on trap
	*  5e3ee11 Merge branch 'master' of git://github.com/dustin/grit
	|\  
	| * 420eac9 Added a method for getting the current branch.
	* | 30e367c timeout code and tests
	* | 5a09431 add timeout protection to grit
	* | e1193f8 support for heads with slashes in them
	|/  
	* d6016bc require time for xmlschema
	*  11d191e Merge branch 'defunkt' into local

Мы рассмотрели только самые простые параметры форматирования вывода для `git log` — их гораздо больше. Таблица 2-2 содержит как параметры уже рассмотренные нами так и другие могущие быть полезными параметры, вместе с описанием эффекта от их использования.

	Параметр	Описание
	-p	Выводит патч(заплатку/diff) внесенный каждым коммитом.
	--stat	Выводит статистику по файлам измененным в каждом коммите.
	--shortstat	Отображает только измененные/добавленные/удаленные строки вывода команды --stat.
	--name-only	Выводит список измененных файлов после каждого коммита.
	--name-status	Выводит список файлов вместе с информацией добавлен/изменен/удален.
	--abbrev-commit	Выводит только первые несколько символов контрольной суммы SHA-1 вместо всех 40.
	--relative-date	Выводит дату в относительном формате (например, “2 недели назад”) вместо использования полного формата даты.
	--graph	Выводит ASCII граф ветвей и истории слияний рядом с выводом лога.
	--pretty	Выводит коммиты в альтернативном формате. Параметры включают oneline, short, full, fuller, и format (где вы можете указать свой собственный формат).

Those are only some simple output-formatting options to `git log` — there are many more. Table 2-2 lists the options we’ve covered so far and some other common formatting options that may be useful, along with how they change the output of the log command.

	Option	Description
	-p	Show the patch introduced with each commit.
	--stat	Show statistics for files modified in each commit.
	--shortstat	Display only the changed/insertions/deletions line from the --stat command.
	--name-only	Show the list of files modified after the commit information.
	--name-status	Show the list of files affected with added/modified/deleted information as well.
	--abbrev-commit	Show only the first few characters of the SHA-1 checksum instead of all 40.
	--relative-date	Display the date in a relative format (for example, “2 weeks ago”) instead of using the full date format.
	--graph	Display an ASCII graph of the branch and merge history beside the log output.
	--pretty	Show commits in an alternate format. Options include oneline, short, full, fuller, and format (where you specify your own format).

### Ограничение вывода команды log ###
### Limiting Log Output ###

Кроме опций для форматирования вывода, git log имеет ряд полезных ограничительных параметров, то есть параметров, которые дают возможность отобразить часть коммитов. Вы уже видели один из таких параметров — параметр `-2`, который отображает только два последних коммита. На самом деле, вы  можете задать `-<n>`, где `n` это количество отображаемых коммитов. На практике вам врядли придётся часто этим пользоваться потому, что по умолчанию Git через канал (pipe) отправляет весь вывод на pager, так что вы всегда будете видеть только одну страницу.

In addition to output-formatting options, git log takes a number of useful limiting options — that is, options that let you show only a subset of commits. You’ve seen one such option already — the `-2` option, which show only the last two commits. In fact, you can do `-<n>`, where `n` is any integer to show the last `n` commits. In reality, you’re unlikely to use that often, because Git by default pipes all output through a pager so you see only one page of log output at a time.

А вот, параметры ограничивающие по времени такие как `--since` и `--until` весьма полезны. Например, следующая команда выдаёт список коммитов сделаных за последние две недели.

However, the time-limiting options such as `--since` and `--until` are very useful. For example, this command gets the list of commits made in the last two weeks:

	$ git log --since=2.weeks

Эта команда может работать с множеством форматов — вы можете указать точную дату (“2008-01-15”) или относительную дату такую как “2 years 1 day 3 minutes ago”.

This command works with lots of formats — you can specify a specific date (“2008-01-15”) or a relative date such as “2 years 1 day 3 minutes ago”.

Вы также можете отфильтровать список коммитов так, чтобы получить те, которые удовлетворяют какому-то критерию поиска. Опция `--author` позволяет фильтровать по автору, опцию `--grep` позволяет искать по ключевым словам в сообщении. (Заметим, что, если вы укажете и опцию author, и опцию grep, то будут найдены все коммиты, которые удовлетворяют первому ИЛИ второму критерию. Чтобы найти коммиты, которые удовлетворяют первому И второму критерию, следует добавить опцию `--all-match`.)

You can also filter the list to commits that match some search criteria. The `--author` option allows you to filter on a specific author, and the `--grep` option lets you search for keywords in the commit messages. (Note that if you want to specify both author and grep options, you have to add `--all-match` or the command will match commits with either.)

Последняя действительно полезная опция-фильтр для `git log` это путь. Указав имя директории или файла, вы ограничите вывод log теми коммитами, которые вносят изменения в указанные файлы. Эта опция всегда указывается последней и обычно предваряется двумя минусами (`--`), чтобы отделить пути от остальных опций.

The last really useful option to pass to `git log` as a filter is a path. If you specify a directory or file name, you can limit the log output to commits that introduced a change to those files. This is always the last option and is generally preceded by double dashes (`--`) to separate the paths from the options.

В таблице 2-3 для справки приведён список частоупоребляемых опций.

In Table 2-3 we’ll list these and a few other common options for your reference.

	Опция	Описание
	-(n)	Показать последние n коммитов
	--since, --after	Ограничить коммиты теми, которые сделаны после указанной даты.
	--until, --before	Ограничить коммиты теми, которые сделаны до указанной даты.
	--author	Показать только те коммиты, автор которых соответствует указанной строке.
	--committer	Показать только те коммиты, коммитер которых соответствует указанной строке.

	Option	Description
	-(n)	Show only the last n commits
	--since, --after	Limit the commits to those made after the specified date.
	--until, --before	Limit the commits to those made before the specified date.
	--author	Only show commits in which the author entry matches the specified string.
	--committer	Only show commits in which the committer entry matches the specified string.

Например, если вы хотите посмотреть из истории Git такие коммиты, которые вносят изменения в тестовые файлы, были сделаны Junio Hamano, не являются слияниями, которые были сделаны в октябре 2008го, вы можете выполнить что-то вроде такого:

For example, if you want to see which commits modifying test files in the Git source code history were committed by Junio Hamano and were not merges in the month of October 2008, you can run something like this:

	$ git log --pretty="%h - %s" --author=gitster --since="2008-10-01" \
	   --before="2008-11-01" --no-merges -- t/
	5610e3b - Fix testcase failure when extended attribute
	acd3b9e - Enhance hold_lock_file_for_{update,append}()
	f563754 - demonstrate breakage of detached checkout wi
	d1a43f2 - reset --hard/read-tree --reset -u: remove un
	51a94af - Fix "checkout --track -b newbranch" on detac
	b0ad11e - pull: allow "git pull origin $something:$cur

Из примерно 20 000 коммитов в истории Git, данная команда выбрала всего 6 коммитов соответствующих заданным критериям.

Of the nearly 20,000 commits in the Git source code history, this command shows the 6 that match those criteria.

### Использование графического интерфейса для визуализации истории ###
### Using a GUI to Visualize History ###

Если у вас есть желание использовать какой-нибудь графический инструмент для визуализации истории коммитов, можно попробовать распространяемую вместе с git программу gitk, написанную на Tcl/Tk. В сущности gitk — это наглядный вариант `git log`, к тому же он принимает почти те же фильтрующие опции, что и `git log`. Если набрать в командной строй gitk находясь в проекте, вы увидете что-то наподобие Рис. 2-2.

If you like to use a more graphical tool to visualize your commit history, you may want to take a look at a Tcl/Tk program called gitk that is distributed with Git. Gitk is basically a visual `git log` tool, and it accepts nearly all the filtering options that `git log` does. If you type gitk on the command line in your project, you should see something like Figure 2-2.

Insert 18333fig0202.png 
Рисунок 2-2. Визуализация история с помощью gitk.
Figure 2-2. The gitk history visualizer.

В верхней части окна располагается история коммитов вместе с подробным графом наследников. Просмотрщик дельт в нижней половине окна отображает изменения сделанные выбранным коммитом. Указать коммит можно с помощью щелчка мышью.

You can see the commit history in the top half of the window along with a nice ancestry graph. The diff viewer in the bottom half of the window shows you the changes introduced at any commit you click.

## Отмена изменений ##
## Undoing Things ##

На любой стадии может возникнуть необходимость что-либо отменить. Здесь мы рассмотрим несколько основных инструментов для отмены произведённых изменений. Будьте осторожны, ибо не всегда можно отменить сами отмены. Это одно из мест в Git, где вы можете потерять свою работу если сделаете что-то неправильно. 

At any stage, you may want to undo something. Here, we’ll review a few basic tools for undoing changes that you’ve made. Be careful, because you can’t always undo some of these undos. This is one of the few areas in Git where you may lose some work if you do it wrong.

### Изменение последнего коммита ###
### Changing Your Last Commit ###

Одна из обычных отмен происходит, когда вы делаете коммит слишком рано забыв добавить какие-то файлы, или напутали с комментарием к коммиту. Если вам хотелось бы сделать этот коммит ещё раз, вы можете выполнить commit с опцией `--amend`.

One of the common undos takes place when you commit too early and possibly forget to add some files, or you mess up your commit message. If you want to try that commit again, you can run commit with the `--amend` option:

	$ git commit --amend

Эта команда берёт индекс и использует его для коммита. Если после последнего коммита не было никаких изменений (например, вы запустили приведённую команду сразу после предыдущего коммита), то состояние проекта будет абсолютно таким же и всё, что вы измените это комментарий к коммиту.

This command takes your staging area and uses it for the commit. If you’ve have made no changes since your last commit (for instance, you run this command immediately after your previous commit), then your snapshot will look exactly the same and all you’ll change is your commit message.

Появится всё тот же редактор для комментариев к коммитам, но уже с введённым комментарем к предыдущему коммиту. Вы можете отредактировать это сообщение так же как обычно, и оно перепишет предыдущее.

The same commit-message editor fires up, but it already contains the message of your previous commit. You can edit the message the same as always, but it overwrites your previous commit.

Для примера, если после совершения коммита вы осознали, что забыли проиндексировать изменения в файле, которые хотели добавить в этот коммит, вы можете сделать что-то подобное:

As an example, if you commit and then realize you forgot to stage the changes in a file you wanted to add to this commit, you can do something like this:

	$ git commit -m 'initial commit'
	$ git add forgotten_file
	$ git commit --amend 

Все три команды вместе дают один коммит — второй коммит заменяет результат первого.

All three of these commands end up with a single commit — the second commit replaces the results of the first.

### Отмена индексации файла ###
### Unstaging a Staged File ###

В следующих двух разделах мы продемонстрируем как переделать проиндексированные изменения и изменения в рабочей директории. Приятно то, что команда используемая для определения состояния этих двух вещей дополнительно напоминает о том как отменить изменения в них. Приведём пример. Допустим вы внесли изменения в два файла и хотите записать их как два отдельных коммита, но случайно набрали `git add *` и проиндексировали оба файла. Как теперь отменить индексацию одного из двух файлов? Комманда `git status` напомнит вам об этом:

The next two sections demonstrate how to wrangle your staging area and working directory changes. The nice part is that the command you use to determine the state of those two areas also reminds you how to undo changes to them. For example, let’s say you’ve changed two files and want to commit them as two separate changes, but you accidentally type `git add *` and stage them both. How can you unstage one of the two? The `git status` command reminds you:

	$ git add .
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       modified:   README.txt
	#       modified:   benchmarks.rb
	#

Сразу после надписи “Changes to be committed”, сказано использовать `git reset HEAD <file>...` для исключения из индекса. Так что давайте последуем совету и отменим индексацию файла benchmarks.rb:

Right below the “Changes to be committed” text, it says use `git reset HEAD <file>...` to unstage. So, let’s use that advice to unstage the benchmarks.rb file:

	$ git reset HEAD benchmarks.rb 
	benchmarks.rb: locally modified
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       modified:   README.txt
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	#       modified:   benchmarks.rb
	#

Эта команда немного странновата, но она сработала. Файл benchmarks.rb изменён, но уже не в индексе.

The command is a bit strange, but it works. The benchmarks.rb file is modified but once again unstaged.

### Отмена изменения файла ###
### Unmodifying a Modified File ###

Что если вы поняли, что не хотите оставлять изменения внесённые в файл benchmarks.rb? Как быстро отменить изменения, вернуть то состояние, в котором он находился во время последнего коммита (или первоначального клонирования, или какого-то другого действия, после которого файл попал в рабочую директорию)? К счастью, `git status` говорит как добиться и этого. В выводе для последнего примера, неиндексированная область выглядит следующим образом:

What if you realize that you don’t want to keep your changes to the benchmarks.rb file? How can you easily unmodify it — revert it back to what it looked like when you last committed (or initially cloned, or however you got it into your working directory)? Luckily, `git status` tells you how to do that, too. In the last example output, the unstaged area looks like this:

	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	#       modified:   benchmarks.rb
	#

Здесь довольно ясно сказано как отменить сделанные изменения (по крайней мере новые версии Git'а, 1.6.1 и дальше, делают это; если у вас более старая версии, мы настоятельно рекомендуем обновиться, чтобы получить некоторые приятные удобные возможности). Давайте сделаем, то что написано:

It tells you pretty explicitly how to discard the changes you’ve made (at least, the newer versions of Git, 1.6.1 and later, do this — if you have an older version, we highly recommend upgrading it to get some of these nicer usability features). Let’s do what it says:

	$ git checkout -- benchmarks.rb
	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       modified:   README.txt
	#

Как вы видите, изменения отменены. Вы должны понимать, что это опасная команда: все сделанные вами изменения в этом файле пропали — вы просто скопировали поверх него другой файл. Никогда не используйте эти команду если вы не полностью уверены, что этот файл вам не нужен. Если вам нужно просто сделать, чтобы он не мешался, мы рассмотрим прятание(??) и ветвление в следующей главе; это обычно более предпочтительный способ.

You can see that the changes have been reverted. You should also realize that this is a dangerous command: any changes you made to that file are gone — you just copied another file over it. Don’t ever use this command unless you absolutely know that you don’t want the file. If you just need to get it out of the way, we’ll go over stashing and branching in the next chapter; these are generally better ways to go. 

Помните, что всё, что является частью коммита в Git, почти всегда может быть восстановлено. Даже коммиты, которые находятся на ветках, которые были удалены, и коммиты переписанные с помощью `--amend` могут быть восстановлены (см. Главу 9 для восстановления данных). Несмотря на это, всё, что никогда не попадало в коммит, вы скорее всего уже не увидете снова.

Remember, anything that is committed in Git can almost always be recovered. Even commits that were on branches that were deleted or commits that were overwritten with an `--amend` commit can be recovered (see Chapter 9 for data recovery). However, anything you lose that was never committed is likely never to be seen again.

## Работа с удалёнными репозиторями ##
## Working with Remotes ##

Чтобы иметь возможность работать вместе над каким-либо Git-проектом, необходимо знать как управлять удалёнными репозиториями. Удалённые репозитории — это модификации проекта, которые хранятся в интернете или ещё где-то в сети. Их может быть несколько, каждый из которых как правило доступен для вас либо только на чтение, либо на чтение и запись. Совместная работа включает в себя управление удалёнными репозиториями и помещение (push) и получение (pull) данных в и из них, когда нужно обменяться результатами работы.
Управление удалёнными репозиториями включает умение добавлять удалённые репозитории, удалять те из них, которые больше не действуют, умение управлять различными удалёнными ветками и определять их как ослеживаемые (tracked) или нет и прочее. Данный раздел охватывает все перечисленные навыки по управлению удалёнными репозиториями.

To be able to collaborate on any Git project, you need to know how to manage your remote repositories. Remote repositories are versions of your project that are hosted on the Internet or network somewhere. You can have several of them, each of which generally is either read-only or read/write for you. Collaborating with others involves managing these remote repositories and pushing and pulling data to and from them when you need to share work.
Managing remote repositories includes knowing how to add remote repositories, remove remotes that are no longer valid, manage various remote branches and define them as being tracked or not, and more. In this section, we’ll cover these remote-management skills.

### Отображение удалённых репозиториев ###
### Showing Your Remotes ###

Чтобы просмотреть какие у вас в настройках есть удалённые серверы, следует выполнить команду git remote. Она выдаёт список имён-сокращений для каждого указанного удалённого объекта. Если вы склонировали ваш репозиторий, у вас должен отобразиться по крайней мере origin — это имя по умолчанию, которое Git присваивает серверу, с которого вы склонировали:

To see which remote servers you have configured, you can run the git remote command. It lists the shortnames of each remote handle you’ve specified. If you’ve cloned your repository, you should at least see origin — that is the default name Git gives to the server you cloned from:

	$ git clone git://github.com/schacon/ticgit.git
	Initialized empty Git repository in /private/tmp/ticgit/.git/
	remote: Counting objects: 595, done.
	remote: Compressing objects: 100% (269/269), done.
	remote: Total 595 (delta 255), reused 589 (delta 253)
	Receiving objects: 100% (595/595), 73.31 KiB | 1 KiB/s, done.
	Resolving deltas: 100% (255/255), done.
	$ cd ticgit
	$ git remote 
	origin

Чтобы посмотреть какой полный URL записан в Git для сокращённого имени, можно указать команде опцию `-v`:

You can also specify `-v`, which shows you the URL that Git has stored for the shortname to be expanded to:

	$ git remote -v
	origin	git://github.com/schacon/ticgit.git

Если у вас больше одного удалённого репозитория, команда покажет их все. Например, мой репозиторий Grit выглядит следующим образом.

If you have more than one remote, the command lists them all. For example, my Grit repository looks something like this.

	$ cd grit
	$ git remote -v
	bakkdoor  git://github.com/bakkdoor/grit.git
	cho45     git://github.com/cho45/grit.git
	defunkt   git://github.com/defunkt/grit.git
	koke      git://github.com/koke/grit.git
	origin    git@github.com:mojombo/grit.git

Это означает, что мы легко можем получить изменения от любого из этих пользователей. Но, заметьте, что origin — это единственный удалённый сервер прописанный как SSH ссылка, поэтому он единственный, в который я могу помещать изменения (это будет рассмотрено в Главе 4).

This means we can pull contributions from any of these users pretty easily. But notice that only the origin remote is an SSH URL, so it’s the only one I can push to (we’ll cover why this is in Chapter 4).

### Добавление удалённых репозиториев ###
### Adding Remote Repositories ###

В предыдущих разделах мы упомянули и немного продемонстрировали добавление удалённых репозиториев, сейчас мы рассмотрим это более детально. Чтобы добавить новый удалённый Git-репозиторий под именем-сокращением, к которому будет проще обращаться, выполните `git remote add [сокращение] [url]`:

I’ve mentioned and given some demonstrations of adding remote repositories in previous sections, but here is how to do it explicitly. To add a new remote Git repository as a shortname you can reference easily, run `git remote add [shortname] [url]`:

	$ git remote
	origin
	$ git remote add pb git://github.com/paulboone/ticgit.git
	$ git remote -v
	origin	git://github.com/schacon/ticgit.git
	pb	git://github.com/paulboone/ticgit.git

Теперь вы можете использовать в командной строке строку pb вместо полного URL. Например, если вы хотите извлечь (fetch) всю информацию, которая есть в репозитории Павла, но нет в вашем, вы можете выполнить git fetch pb: 

Now you can use the string pb on the command line in lieu of the whole URL. For example, if you want to fetch all the information that Paul has but that you don’t yet have in your repository, you can run git fetch pb:

	$ git fetch pb
	remote: Counting objects: 58, done.
	remote: Compressing objects: 100% (41/41), done.
	remote: Total 44 (delta 24), reused 1 (delta 0)
	Unpacking objects: 100% (44/44), done.
	From git://github.com/paulboone/ticgit
	 * [new branch]      master     -> pb/master
	 * [new branch]      ticgit     -> pb/ticgit

Ветка master Павла теперь доступна локально как `pb/master`. Вы можете слить (merge) её в одну из ваших веток, или сейчас вы можете перейти на эту ветку если вы хотите её просмотреть.

Paul’s master branch is accessible locally as `pb/master` — you can merge it into one of your branches, or you can check out a local branch at that point if you want to inspect it.

### Fetch и Pull ### 
### Fetching and Pulling from Your Remotes ###

Как вы только что узнали, для получения данных из удалённых проектов, следует выполнить:

As you just saw, to get data from your remote projects, you can run:

	$ git fetch [remote-name]

Данная команда посылается указанному удалённому проекту и забирает все те данные из этого удалённого проекта, которых у вас ещё нет. После того как вы выполнили команду, у вас должны появиться ссылки на все ветки из этого удалённого проекта. Теперь эти ветки в любой момент могут быть просмотрены или слиты. (В 3 Главе мы перейдём к более детальному рассмотрению, что такое ветки и как их использовать.)

The command goes out to that remote project and pulls down all the data from that remote project that you don’t have yet. After you do this, you should have references to all the branches from that remote, which you can merge in or inspect at any time. (We’ll go over what branches are and how to use them in much more detail in Chapter 3.)

Когда вы клонируете (clone) репозиторий, команда автоматически добавляет этот удалённый репозиторий под именем origin. Таким образом `git fetch origin` извлекает все наработки, отправленные (push) на этот сервер после того, как вы склонировали его (или получили изменения с помощью fetch). Важно отметить, что команда fetch забирает данные в ваш локальный репозиторий, но не сливает их с какой-либо вашей работой, и не модифицирует то, над чем вы в данный момент работаете. Необходимо вручную слить эти данные с вашими наработками, когда вы будете готовы.

If you clone a repository, the command automatically adds that remote repository under the name origin. So, `git fetch origin` fetches any new work that has been pushed to that server since you cloned (or last fetched from) it. It’s important to note that the fetch command pulls the data to your local repository — it doesn’t automatically merge it with any of your work or modify what you’re currently working on. You have to merge it manually into your work when you’re ready.

Если у вас есть ветка настроенная на отслеживание удалённой ветки (для дополнительной информации смотри следующий раздел и Главу 3), то вы можете использовать команду `git pull`. Она автоматичеси извлекает и затем сливает данные из удалённой ветки в вашу текущую ветку. Этот способ для вас может оказаться более простым или более удобным. К тому же по умолчанию команда `git clone` автоматически настраивает вашу локальную ветку master на отслеживание удалённой ветки master на сервере, с которого вы клонировали (подразумевается, что на удалённом сервере есть ветка master). Выполнение `git pull` как правило извлекает (fetch) данные с сервера, с которого вы изначально склонировали, и автоматически пытается слить (merge) их с кодом, над которым вы в данный момент работаете.

If you have a branch set up to track a remote branch (see the next section and Chapter 3 for more information), you can use the `git pull` command to automatically fetch and then merge a remote branch into your current branch. This may be an easier or more comfortable workflow for you; and by default, the `git clone` command automatically sets up your local master branch to track the remote master branch on the server you cloned from (assuming the remote has a master branch). Running `git pull` generally fetches data from the server you originally cloned from and automatically tries to merge it into the code you’re currently working on.

### Push ### 
### Pushing to Your Remotes ###

Когда ваш проект достигает момента, когда вы хотите поделиться наработками, вам необходимо отправить (push) их в главный репозиторий. Команда для этого действия простая: `git push [удал. сервер] [ветка]`. Чтобы отправить вашу ветку master на сервер `origin` (повторимся, что клонирование как правило настраивает оба этих имени автоматически), вы можете выполнить следующую команду для отправки наработок обратно на сервер:

When you have your project at a point that you want to share, you have to push it upstream. The command for this is simple: `git push [remote-name] [branch-name]`. If you want to push your master branch to your `origin` server (again, cloning generally sets up both of those names for you automatically), then you can run this to push your work back up to the server:

	$ git push origin master

Эта команда срабатывает только в случае, если вы клонировали с сервера, на котором у вас есть права на запись, и если никто другой с тех пор не выполнял команду push. Если вы и кто-то ещё одновременно клонируете, затем они выполняют команду push, а затем команду push выполняете вы, то ваш push точно будет отклонён. Вам придётся сначала вытянуть (pull) их изменения и объединить с вашими. Только после этого вам будет позволено выполнить push. Смотри Главу 3 для более подробного описания как отправлять (push) данные на удалённый сервер.

This command works only if you cloned from a server to which you have write access and if nobody has pushed in the meantime. If you and someone else clone at the same time and they push upstream and then you push upstream, your push will rightly be rejected. You’ll have to pull down their work first and incorporate it into yours before you’ll be allowed to push. See Chapter 3 for more detailed information on how to push to remote servers.

### Проверка удалённого репозитория ###
### Inspecting a Remote ###

Если хотите получить побольше информации об одном из удалённых репозиториев, вы можете использовать команду `git remote show [удал. сервер]`. Если вы выполните эту команду с некоторым именем, например, `origin`, вы получите что-то подобное:

If you want to see more information about a particular remote, you can use the `git remote show [remote-name]` command. If you run this command with a particular shortname, such as `origin`, you get something like this:

	$ git remote show origin
	* remote origin
	  URL: git://github.com/schacon/ticgit.git
	  Remote branch merged with 'git pull' while on branch master
	    master
	  Tracked remote branches
	    master
	    ticgit

Она выдаёт URL удалённого репозитория, а также информацию об отслеживаемых ветках. Эта команда любезно сообщает вам, что, если вы находясь на ветке master, выполните `git pull`, ветка master с удалённого сервера будет автоматически влита в вашу сразу после получения всех необходимых данных. Она также выдаёт список всех полученных ею ссылок.

It lists the URL for the remote repository as well as the tracking branch information. The command helpfully tells you that if you’re on the master branch and you run `git pull`, it will automatically merge in the master branch on the remote after it fetches all the remote references. It also lists all the remote references it has pulled down.

Это был пример для простой ситуации, и наверняка вы встретились с чем-то подобным. Однако, если вы используете Git более интенсивно, вы можете увидеть гораздо большее количество информации от `git remote show`:

That is a simple example you’re likely to encounter. When you’re using Git more heavily, however, you may see much more information from `git remote show`:

	$ git remote show origin
	* remote origin
	  URL: git@github.com:defunkt/github.git
	  Remote branch merged with 'git pull' while on branch issues
	    issues
	  Remote branch merged with 'git pull' while on branch master
	    master
	  New remote branches (next fetch will store in remotes/origin)
	    caching
	  Stale tracking branches (use 'git remote prune')
	    libwalker
	    walker2
	  Tracked remote branches
	    acl
	    apiv2
	    dashboard2
	    issues
	    master
	    postgres
	  Local branch pushed with 'git push'
	    master:master

Данная команда показывает какая именно локальная ветка будет отправлена на удалённый сервер по умолчанию при выполнении `git push`. Она также показывает каких веток с удалённого сервера у вас ещё нет, какие ветки всё ещё есть у вас, но уже удалены на сервере. И для нескольких веток показано какие удалённые ветки будут в них влиты при выполнении `git pull`.

This command shows which branch is automatically pushed when you run `git push` on certain branches. It also shows you which remote branches on the server you don’t yet have, which remote branches you have that have been removed from the server, and multiple branches that are automatically merged when you run `git pull`.

### Удаление и переименование удалённых репозиториев ###
### Removing and Renaming Remotes ###

Для переименования ссылок в новых версиях Git можно вылолнить `git remote rename`, это изменит сокращённое имя, используемое для удалённого репозитория. Например, если вы хотите переименовать `pb` в `paul`, вы можете сделать это следующим образом:

If you want to rename a reference, in newer versions of Git you can run `git remote rename` to change a remote’s shortname. For instance, if you want to rename `pb` to `paul`, you can do so with `git remote rename`:

	$ git remote rename pb paul
	$ git remote
	origin
	paul

Стоит упомянуть, что это также изменяет для вас имена удалённых веток. То, к чему вы обращались как `pb/master`, стало `paul/master`.

It’s worth mentioning that this changes your remote branch names, too. What used to be referenced at `pb/master` is now at `paul/master`.

Если по какой-то причине вы хотите удалить ссылку (вы сменили сервер или больше не используете определённое зеркало, или, возможно, контрибьютор перестал быть активным), вы можете использовать `git remote rm`:

If you want to remove a reference for some reason — you’ve moved the server or are no longer using a particular mirror, or perhaps a contributor isn’t contributing anymore — you can use `git remote rm`:

	$ git remote rm paul
	$ git remote
	origin

## Создание тегов (tags) ##

Как и большинство систем контроля версий, Git имеет возможность помечать конкретные моменты в истории как важные. Как правило, люди используют эту функциональность, чтобы отметить релизы (v1.0, и так далее). В этом разделе вы узнаете, как получить список доступных тегов, как создать новые, а также узнаете какие бывают типы тегов и их отличия друг от друга.

### Просмотр ваших тегов ###

Для получения списка тегов достаточно просто набрать команду `git tag`:

	$ git tag
	v0.1
	v1.3

Эта команда выводит список тегов в алфавитном порядке; порядок, в котором они назначаются не имеет никакого значения.

Вы также можете вывести теги по шаблону. Репозиторий Git, к примеру, содержит более 240 тегов. Если вас интересуют теги только релиза 1.4.2, вы можете просмотреть их следующим образом:

	$ git tag -l 'v1.4.2.*'
	v1.4.2.1
	v1.4.2.2
	v1.4.2.3
	v1.4.2.4

### Создание тегов ###

Git использует два основных типа тегов: легковесные и аннотированные. Легковесные теги очень похож на ветку (branch), который не изменяется - это просто указатель на конкретный коммит. Аннотированные теги, однако, хранятся как стандартные объекты в базе данных Git. Они имеют контрольную сумму, имеют автора, адрес его электронной почты, а также дату; имеют сообщение коммита, и могут быть подписаны и проверены с GNU Privacy Guard (GPG). Обычно рекомендуется создать аннотированные теги, чтобы вы могли иметь всю эту информацию, но если вы хотите создать временный тег или по какой-то причине не хотите сохранять другую информацию, вам необходимо использовать легковесные теги.

### Аннотированные теги ###

Creating an annotated tag in Git is simple. The easiest way is to specify `-a` when you run the `tag` command:

	$ git tag -a v1.4 -m 'my version 1.4'
	$ git tag
	v0.1
	v1.3
	v1.4

The `-m` specifies a tagging message, which is stored with the tag. If you don’t specify a message for an annotated tag, Git launches your editor so you can type it in.

You can see the tag data along with the commit that was tagged by using the `git show` command:

	$ git show v1.4
	tag v1.4
	Tagger: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Feb 9 14:45:11 2009 -0800

	my version 1.4
	commit 15027957951b64cf874c3557a0f3547bd83b3ff6
	Merge: 4a447f7... a6b4c97...
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sun Feb 8 19:02:46 2009 -0800

	    Merge branch 'experiment'

That shows the tagger information, the date the commit was tagged, and the annotation message before showing the commit information.

### Подписывание тегов ###

You can also sign your tags with GPG, assuming you have a private key. All you have to do is use `-s` instead of `-a`:

	$ git tag -s v1.5 -m 'my signed 1.5 tag'
	You need a passphrase to unlock the secret key for
	user: "Scott Chacon <schacon@gee-mail.com>"
	1024-bit DSA key, ID F721C45A, created 2009-02-09

If you run `git show` on that tag, you can see your GPG signature attached to it:

	$ git show v1.5
	tag v1.5
	Tagger: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Feb 9 15:22:20 2009 -0800

	my signed 1.5 tag
	-----BEGIN PGP SIGNATURE-----
	Version: GnuPG v1.4.8 (Darwin)

	iEYEABECAAYFAkmQurIACgkQON3DxfchxFr5cACeIMN+ZxLKggJQf0QYiQBwgySN
	Ki0An2JeAVUCAiJ7Ox6ZEtK+NvZAj82/
	=WryJ
	-----END PGP SIGNATURE-----
	commit 15027957951b64cf874c3557a0f3547bd83b3ff6
	Merge: 4a447f7... a6b4c97...
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sun Feb 8 19:02:46 2009 -0800

	    Merge branch 'experiment'

A bit later, you’ll learn how to verify signed tags.

### Легковесные теги ###

Другой способ пометить коммит — использовать легковесный тег. Сохраняется только имя тега и указатель на коммит, никакая другая информация не сохраняется. Чтобы создать легковесный тег, не пишите ключи -a, -s, или -m:

	$ git tag v1.4-lw
	$ git tag
	v0.1
	v1.3
	v1.4
	v1.4-lw
	v1.5

На этот раз, если вы запустите `git show имя_тега`, вы не увидите дополнительную информацию. Команда только выведет коммит:

	$ git show v1.4-lw
	commit 15027957951b64cf874c3557a0f3547bd83b3ff6
	Merge: 4a447f7... a6b4c97...
	Author: Scott Chacon <schacon@gee-mail.com>
	Date:   Sun Feb 8 19:02:46 2009 -0800

	    Merge branch 'experiment'

### Проверка тегов ###

To verify a signed tag, you use `git tag -v [tag-name]`. This command uses GPG to verify the signature. You need the signer’s public key in your keyring for this to work properly:

	$ git tag -v v1.4.2.1
	object 883653babd8ee7ea23e6a5c392bb739348b1eb61
	type commit
	tag v1.4.2.1
	tagger Junio C Hamano <junkio@cox.net> 1158138501 -0700

	GIT 1.4.2.1

	Minor fixes since 1.4.2, including git-mv and git-http with alternates.
	gpg: Signature made Wed Sep 13 02:08:25 2006 PDT using DSA key ID F3119B9A
	gpg: Good signature from "Junio C Hamano <junkio@cox.net>"
	gpg:                 aka "[jpeg image of size 1513]"
	Primary key fingerprint: 3565 2A26 2040 E066 C9A7  4A7D C0C6 D9A4 F311 9B9A

If you don’t have the signer’s public key, you get something like this instead:

	gpg: Signature made Wed Sep 13 02:08:25 2006 PDT using DSA key ID F3119B9A
	gpg: Can't check signature: public key not found
	error: could not verify the tag 'v1.4.2.1'

### Tagging Later ###

You can also tag commits after you’ve moved past them. Suppose your commit history looks like this:

	$ git log --pretty=oneline
	15027957951b64cf874c3557a0f3547bd83b3ff6 Merge branch 'experiment'
	a6b4c97498bd301d84096da251c98a07c7723e65 beginning write support
	0d52aaab4479697da7686c15f77a3d64d9165190 one more thing
	6d52a271eda8725415634dd79daabbc4d9b6008e Merge branch 'experiment'
	0b7434d86859cc7b8c3d5e1dddfed66ff742fcbc added a commit function
	4682c3261057305bdd616e23b64b0857d832627b added a todo file
	166ae0c4d3f420721acbb115cc33848dfcc2121a started write support
	9fceb02d0ae598e95dc970b74767f19372d61af8 updated rakefile
	964f16d36dfccde844893cac5b347e7b3d44abbc commit the todo
	8a5cbc430f1a9c3d00faaeffd07798508422908a updated readme

Now, suppose you forgot to tag the project at v1.2, which was at the "updated rakefile" commit. You can add it after the fact. To tag that commit, you specify the commit checksum (or part of it) at the end of the command:

	$ git tag -a v1.2 9fceb02

You can see that you’ve tagged the commit:

	$ git tag 
	v0.1
	v1.2
	v1.3
	v1.4
	v1.4-lw
	v1.5

	$ git show v1.2
	tag v1.2
	Tagger: Scott Chacon <schacon@gee-mail.com>
	Date:   Mon Feb 9 15:32:16 2009 -0800

	version 1.2
	commit 9fceb02d0ae598e95dc970b74767f19372d61af8
	Author: Magnus Chacon <mchacon@gee-mail.com>
	Date:   Sun Apr 27 20:43:35 2008 -0700

	    updated rakefile
	...

### Sharing Tags ###

By default, the `git push` command doesn’t transfer tags to remote servers. You will have to explicitly push tags to a shared server after you have created them.  This process is just like sharing remote branches – you can run `git push origin [tagname]`.

	$ git push origin v1.5
	Counting objects: 50, done.
	Compressing objects: 100% (38/38), done.
	Writing objects: 100% (44/44), 4.56 KiB, done.
	Total 44 (delta 18), reused 8 (delta 1)
	To git@github.com:schacon/simplegit.git
	* [new tag]         v1.5 -> v1.5

If you have a lot of tags that you want to push up at once, you can also use the `--tags` option to the `git push` command.  This will transfer all of your tags to the remote server that are not already there.

	$ git push origin --tags
	Counting objects: 50, done.
	Compressing objects: 100% (38/38), done.
	Writing objects: 100% (44/44), 4.56 KiB, done.
	Total 44 (delta 18), reused 8 (delta 1)
	To git@github.com:schacon/simplegit.git
	 * [new tag]         v0.1 -> v0.1
	 * [new tag]         v1.2 -> v1.2
	 * [new tag]         v1.4 -> v1.4
	 * [new tag]         v1.4-lw -> v1.4-lw
	 * [new tag]         v1.5 -> v1.5

Now, when someone else clones or pulls from your repository, they will get all your tags as well.

## Tips and Tricks ##

Before we finish this chapter on basic Git, a few little tips and tricks may make your Git experience a bit simpler, easier, or more familiar. Many people use Git without using any of these tips, and we won’t refer to them or assume you’ve used them later in the book; but you should probably know how to do them.

### Auto-Completion ###

If you use the Bash shell, Git comes with a nice auto-completion script you can enable. Download the Git source code, and look in the `contrib/completion` directory; there should be a file called `git-completion.bash`. Copy this file to your home directory, and add this to your `.bashrc` file:

	source ~/.git-completion.bash

If you want to set up Git to automatically have Bash shell completion for all users, copy this script to the `/opt/local/etc/bash_completion.d` directory on Mac systems or to the `/etc/bash_completion.d/` directory on Linux systems. This is a directory of scripts that Bash will automatically load to provide shell completions.

If you’re using Windows with Git Bash, which is the default when installing Git on Windows with msysGit, auto-completion should be preconfigured.

Press the Tab key when you’re writing a Git command, and it should return a set of suggestions for you to pick from:

	$ git co<tab><tab>
	commit config

In this case, typing git co and then pressing the Tab key twice suggests commit and config. Adding `m<tab>` completes `git commit` automatically.
	
This also works with options, which is probably more useful. For instance, if you’re running a `git log` command and can’t remember one of the options, you can start typing it and press Tab to see what matches:

	$ git log --s<tab>
	--shortstat  --since=  --src-prefix=  --stat   --summary

That’s a pretty nice trick and may save you some time and documentation reading.

### Git Aliases ###

Git doesn’t infer your command if you type it in partially. If you don’t want to type the entire text of each of the Git commands, you can easily set up an alias for each command using `git config`. Here are a couple of examples you may want to set up:

	$ git config --global alias.co checkout
	$ git config --global alias.br branch
	$ git config --global alias.ci commit
	$ git config --global alias.st status

This means that, for example, instead of typing `git commit`, you just need to type `git ci`. As you go on using Git, you’ll probably use other commands frequently as well; in this case, don’t hesitate to create new aliases.

This technique can also be very useful in creating commands that you think should exist. For example, to correct the usability problem you encountered with unstaging a file, you can add your own unstage alias to Git:

	$ git config --global alias.unstage 'reset HEAD --'

This makes the following two commands equivalent:

	$ git unstage fileA
	$ git reset HEAD fileA

This seems a bit clearer. It’s also common to add a `last` command, like this:

	$ git config --global alias.last 'log -1 HEAD'

This way, you can see the last commit easily:
	
	$ git last
	commit 66938dae3329c7aebe598c2246a8e6af90d04646
	Author: Josh Goebel <dreamer3@example.com>
	Date:   Tue Aug 26 19:48:51 2008 +0800

	    test for current head

	    Signed-off-by: Scott Chacon <schacon@example.com>

As you can tell, Git simply replaces the new command with whatever you alias it for. However, maybe you want to run an external command, rather than a Git subcommand. In that case, you start the command with a `!` character. This is useful if you write your own tools that work with a Git repository. We can demonstrate by aliasing `git visual` to run `gitk`:

	$ git config --global alias.visual "!gitk"

## Summary ##

At this point, you can do all the basic local Git operations — creating or cloning a repository, making changes, staging and committing those changes, and viewing the history of all the changes the repository has been through. Next, we’ll cover Git’s killer feature: its branching model.
