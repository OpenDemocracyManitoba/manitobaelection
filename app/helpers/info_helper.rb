module InfoHelper
  def prefixed_pluralize(count, singular_prefix, plural_prefix, singular_suffix, plural_suffix = nil)
    prefix = (count == 1) ? singular_prefix : plural_prefix
    "#{prefix} #{pluralize(count, singular_suffix, plural_suffix)}"
  end
end
