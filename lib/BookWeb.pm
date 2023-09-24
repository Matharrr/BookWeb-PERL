package BookWeb;
use Dancer::Plugin::DBIC;
use Dancer ':syntax';
use DateTime;

get '/' => sub {
    my $books_rs = schema->resultset('Book');

    my @reading = $books_rs->search(
        {
            started => { '!=', undef },
            ended   => undef,
        }
    );

    my @read = $books_rs->search(
        {
            ended => { '!=', undef },
        }
    );

    my @to_read = $books_rs->search(
        {
            started => undef,
        }
    );

    template 'index',
      {
        reading => \@reading,
        read    => \@read,
        to_read => \@to_read,
      };
};
true;
