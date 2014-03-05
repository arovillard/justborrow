module ApplicationHelper
  def meta(field = nil, list = [])
  field = field.to_s
  @meta ||= {
    'robots' => ['all'],
    'copyright' => ['Copyright JustBorrowIT'],
    'content-language' => ['en'],
    'title' => [JustBorrowIt],
    'keywords' => [],
    'description' => ['JustBorrow.it is the safest and easist way to borrow almost anything from anyone!']
  }

  if field.present?
    @meta[field] ||= []
    case list.class
      when Array then
        @meta[field] += list
      when String then
        @meta[field] += [list]
      else
        @meta[field] += [list]
    end

    case field
      when 'description' then
        content = truncate(strip_tags(h(@meta[field].join(', '))), :length => 255)
      else
        content = @meta[field].join(', ')
    end

    return raw(%(<meta #{att}="#{h(field)}" content="#{h(content)}"/>))
  else
    tags = ''
    @meta.each do |field, list|
      tags += meta(field)+"\n"
    end
    return tags.rstrip
  end
end
end
