import { View } from "react-native";
import { cn } from "@/lib/utils";

function Skeleton({
  className,
  style,
  ...props
}: React.ComponentProps<typeof View> & React.RefAttributes<View>) {
  return (
    <View
      className={cn("rounded-md", className)}
      style={[{ backgroundColor: "#E5E5EA" }, style]}
      {...props}
    />
  );
}

export { Skeleton };
