interface CategoryBadgeProps {
  category: string;
}

export const CategoryBadge = ({ category }: CategoryBadgeProps) => {
  return (
    <span className="px-3 py-1 bg-sky-900 rounded-md text-xs text-gray-100 hover:text-white cursor-pointer transition-colors">
      {category}
    </span>
  );
};
