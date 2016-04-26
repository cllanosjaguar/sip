
valida: valida-js valida-ruby

valida-js:
	for i in `find app/assets/javascripts/ -name "*coffee"`; do \
	coffee -o /tmp/ $$i; \
	done

valida-ruby:
	find . -name "*\.rb" -exec ruby -w -W2 -c {} ';'

instala-gemas:
	grep "([0-9]" Gemfile.lock  | sed -e "s/^ */doas gem install /g;s/ (/ -v /g;s/)//g" > /tmp/i.sh
	doas chmod +x /tmp/i.sh
	doas /tmp/i.sh
